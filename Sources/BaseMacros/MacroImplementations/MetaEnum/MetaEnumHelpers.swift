//
//  MetaEnumHelpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/10/2025.
//

//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import MacroToolkit
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

//public struct MetaEnumMacro {

struct MetaEnumBuilder {
  let detectedEnum: Enum
  let parentParamName: TokenSyntax
  let caseDetection: CaseDetectionMacro
}

extension MetaEnumBuilder {

  init(
    node: AttributeSyntax,
    decl: some DeclGroupSyntax,
    context: some MacroExpansionContext,
  ) throws {

    guard let enumDecl = decl as? EnumDeclSyntax else {
      throw MacroError("@MetaEnum can only be attached to enum declarations")
    }
    self.detectedEnum = Enum(enumDecl)

    self.caseDetection = try CaseDetectionMacro(
      node: node,
      decl: decl
    )

    self.parentParamName = context.makeUniqueName("parent")
  }
}

extension MetaEnumBuilder {

  var parentTypeName: String { detectedEnum.identifier }
  var access: String { detectedEnum.accessLevel?.name ?? "" }
  var childCases: [EnumCase] { detectedEnum.cases }

  func makeMetaEnum() -> [DeclSyntax] {

    let meta: DeclSyntax = """
      \(raw: access) enum Meta: String, CaseIterable, Identifiable {
      \(raw: caseDecls)
      \(makeMetaInit())
      \(caseNames)
      \(idProperty)
      \(raw: detections)
      }
      """
    return [meta]
  }

  func makeMetaInit() -> DeclSyntax {
    let caseStatements =
      childCases
      .map { childCase in
        """
          case .\(childCase.identifier):
            self = .\(childCase.identifier)
        """
      }
      .joined(separator: "\n")

    return """
      \(raw: access) init(_ \(parentParamName): \(raw: parentTypeName)) {
        switch \(parentParamName) {
      \(raw: caseStatements)
        }
      }
      """
  }

  /// ## Meta enum declaration
  /// ```
  /// enum Meta {
  ///   case bird
  ///   case whale
  /// […]
  private var caseDecls: String {
    return
      childCases
      .map { childCase in
        "  case \(childCase.identifier)"
      }
      .joined(separator: "\n")
  }

  /// ## Initialiser
  /// ```
  ///   init(_ abc123: ParentEnum) {
  ///     switch abc123 {
  ///       case .bird:
  ///         self = .bird
  ///       case .whale:
  ///         self = .whale
  ///     }
  ///   }
  ///

  /// ## Case Names
  /// ```
  /// var name: String {
  ///   case .bird: "Bird"
  ///   case .whale: "Whale"
  /// }
  /// ```
  var caseNames: DeclSyntax {

    let cases = childCases.map { childCase in
      "case .\(childCase.identifier): \"\(childCase.identifier.capitalized)\""
    }.joined(separator: "\n")

    return
      """
      \(raw: access) var name: String {
        switch self {
          \(raw: cases)
        }
      }
      """
  }

  /// ## ID property
  /// ```
  /// var id: String { rawValue }
  /// ```
  var idProperty: DeclSyntax {

    //    let cases = childCases.map { childCase in
    //      "case .\(childCase.identifier): \"\(childCase.identifier.capitalized)\""
    //    }.joined(separator: "\n")

    return
      """
      \(raw: access) var id: String { rawValue }
      """
  }

  /// ## Case Detection
  ///
  /// ```
  /// var isBird: Bool {
  ///   if case .bird = self {
  ///     return true
  ///   }
  ///   return false
  /// }
  /// […]
  ///
  /// ```
  var detections: String {
    caseDetection.makeCaseDetector().map { item in
      "\(item)"
    }.joined(separator: "\n")
  }
}
