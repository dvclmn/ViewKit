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

public struct MetaEnumMacro {

  let detectedEnum: Enum
  let parentParamName: TokenSyntax
  let caseDetection: CaseDetectionMacro

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

extension MetaEnumMacro {

  var parentTypeName: String { detectedEnum.identifier }
  var access: String { detectedEnum.accessLevel?.name ?? "" }
  var childCases: [EnumCase] { detectedEnum.cases }

  func makeMetaEnum() -> [DeclSyntax] {

    let names = childCases.map { childCase in
      "\(childCase.identifier)"
    }

    let meta: DeclSyntax = """
      \(raw: access)enum Meta {
      \(raw: caseDecls)
      \(makeMetaInit())
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
      \(raw: access)init(_ \(parentParamName): \(raw: parentTypeName)) {
        switch \(parentParamName) {
      \(raw: caseStatements)
        }
      }
      """
  }

  /// ```
  /// // Meta enum declaration
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

  /// ```
  /// // Initialiser
  ///   init(_ abc123: ParentEnum) {
  ///     switch abc123 {
  ///       case .bird:
  ///         self = .bird
  ///       case .whale:
  ///         self = .whale
  ///     }
  ///   }
  ///
  /// // Case names

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
