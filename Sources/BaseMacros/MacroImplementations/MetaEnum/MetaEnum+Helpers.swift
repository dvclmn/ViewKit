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

extension MetaEnumBuilder {

  func makeMetaEnum() -> [DeclSyntax] {
    [
      // Properties on Parent
      DeclSyntax("\(raw: access) var meta: Self.Meta {.init(self)}"),
      DeclSyntax("\(raw: access) var hasAssociatedValues: Bool {.init(self)}"),
      DeclSyntax(metaToParentInit),

      // Beginning of Meta enum declaration
      DeclSyntax("\(raw: access) enum Meta: String, CaseIterable, Identifiable {"),
      DeclSyntax(stringLiteral: metaCases),
      DeclSyntax(makeMetaInit()),
      DeclSyntax(caseNames),
      DeclSyntax("\(raw: access) var id: String {rawValue}"),
      DeclSyntax(metaToParentConvenience),
      DeclSyntax(stringLiteral: detections),

      // End brace for Meta enum
      DeclSyntax("}"),
    ]
  }
}

extension MetaEnumBuilder {

  func makeMetaInit() -> DeclSyntax {

    let cases = casesList { item in
      "self = .\(item.name)"
    }
    //    let caseStatements =
    //      childCases
    //      .map { childCase in
    //        """
    //          \()
    //
    //        """
    //      }
    //      .joined(separator: "\n")

    return """
      \(raw: access) init(_ \(parentParamName): \(raw: parentTypeName)) {
        switch \(parentParamName) {
      \(raw: cases)
        }
      }
      """
  }

  func hasAssociatedValues(_ case: EnumCase) -> Bool {
    childCases.contains(where: \.hasAssociatedValues)
  }

  var hasAnyAssociatedValues: Bool {
    childCases.contains(where: \.hasAssociatedValues)
  }

  private var associatedValuesCheck: DeclSyntax {
    """
    \(raw: access) init?(fromMeta meta: Self.Meta) {
      switch meta {
    \(raw: casesList())
      }
    }
    """
  }

  /// ```
  /// public init?(fromMeta meta: Self.Meta) {
  ///   switch meta {
  ///     case .linear: self = .linear
  ///     case .cubic: self = .cubic
  ///     case .quadratic: self = .quadratic
  ///     case .catmullRom: return nil
  ///   }
  /// }
  /// ```
  private var metaToParentInit: DeclSyntax {
    """
    \(raw: access) init?(fromMeta meta: Self.Meta) {
      switch meta {
    \(raw: casesList(caseResult($0)))
      }
    }
    """
  }

  private var metaToParentConvenience: DeclSyntax {
    "\(raw: access) var parent: \(raw: parentTypeName)? { .init(fromMeta: self) } "
  }

  private func caseResult(_ item: MetaEnumCase) -> String {
    item.hasAssociatedValues
      ? "return nil"
      : "self = .\(item.name)"
  }

  /// ## Meta enum declaration
  /// ```
  /// enum Meta {
  ///   case bird
  ///   case whale
  /// […]
  private var metaCases: String {
    childCases
      .map { "  case \($0.name)" }
      .joined("\n")
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
      "case .\(childCase.name): \"\(childCase.name.capitalized)\""
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
