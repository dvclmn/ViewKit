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

  func build() -> [DeclSyntax] {
    [
      // Properties on Parent
      DeclSyntax("\(raw: access) var meta: Self.Meta {.init(self)}"),
      DeclSyntax(hasAssociatedValuesProperty),
      DeclSyntax(metaToParentInit),
    ]

      // Beginning of Meta enum declaration
      + [DeclSyntax("\(raw: access) enum Meta: String, CaseIterable, Identifiable {")]

      + metaEnumInternals
      + caseDetection

      // End brace for Meta enum
      + [DeclSyntax("}")]

  }

  private var metaEnumInternals: [DeclSyntax] {
    [
      /// Lists out the canonical Meta case declarations
      DeclSyntax(metaCases),

      /// Creates initialiser allowing creation of a Meta enum from parent
      DeclSyntax(makeMetaInit),

      DeclSyntax(metaNameProperty),
      DeclSyntax(metaIDProperty),
      DeclSyntax(metaToParentConvenience),
    ]

  }
}

extension MetaEnumBuilder {

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
  private var makeMetaInit: DeclSyntax {
    let cases = casesList { item in
      "self = .\(item.name)"
    }

    return """
      \(raw: access) init(_ \(parentParamName): \(raw: parentTypeName)) {
        switch \(parentParamName) {
      \(raw: cases)
        }
      }
      """
  }

  /// Target output:
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
  /// Note: Could try using this to generate more defaults:
  /// https://github.com/alschmut/SwiftBuildableMacro?tab=readme-ov-file#builder-default-values
  private var metaToParentInit: DeclSyntax {
    let cases = casesList { item in
      if !item.hasAssociatedValues {
        return "self = .\(item.name)"
      }

      /// Attempt to construct using default values for associated parameters, if all are present
      let defaults = item.defaultValuesIfPresent
      guard let paramClause = item.associatedValues else {
//      guard let paramClause = item.enumCase._syntax.parameterClause else {
        return "return nil"
      }

      // Only proceed if every parameter has a default value
      let allHaveDefaults = paramClause.parameters.allSatisfy { $0.defaultValue != nil }
      guard allHaveDefaults else {
        return "return nil"
      }

      // Build an argument list using the default value expressions
      let argumentList: String = paramClause.parameters.compactMap { param in
        // Prefer using the parameter's first name if available
        let label = param.firstName?.text ?? "_"
        if let value = param.defaultValue?.value {
          return "\(label): \(value)"
        }
        return nil
      }.joined(separator: ", ")

      return "self = .\(item.name)(\(argumentList))"
    }

    return """
      \(raw: access) init?(fromMeta meta: Self.Meta) {
        switch meta {
      \(raw: cases)
        }
      }
      """
  }

  private var metaToParentConvenience: DeclSyntax {
    "\(raw: access) var parent: \(raw: parentTypeName)? { .init(fromMeta: self) } "
  }

  /// ## Meta enum declaration
  /// ```
  /// enum Meta {
  ///   case bird
  ///   case whale
  /// […]
  private var metaCases: DeclSyntax {
    childCases
      .map { "  case \($0.name)" }
      .joined("\n")
      .toDeclSyntax
  }

  /// ## Case Names
  /// ```
  /// var name: String {
  ///   case .bird: "Bird"
  ///   case .whale: "Whale"
  /// }
  /// ```
  var metaNameProperty: DeclSyntax {
    let cases = casesList {
      "\"\($0.name.capitalized)\""
    }

    return
      """
      \(raw: access) var name: String {
        switch self {
          \(raw: cases)
        }
      }
      """
  }

  var metaIDProperty: DeclSyntax { "\(raw: access) var id: String {rawValue}" }

  var hasAssociatedValuesProperty: DeclSyntax {
    let cases = casesList {
      "\($0.hasAssociatedValues ? "true" : "false")"
    }

    return
      """
      \(raw: access) var hasAssociatedValues: Bool {
        switch self {
          \(raw: cases)
        }
      }
      """
  }
}
