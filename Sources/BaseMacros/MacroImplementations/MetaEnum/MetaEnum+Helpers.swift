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
      DeclSyntax("\(raw: detectedEnum.access) var meta: Self.Meta {.init(self)}"),
      DeclSyntax(hasAssociatedValuesProperty),
      DeclSyntax(metaToParentInit),
    ]

      // Beginning of Meta enum declaration
    + [DeclSyntax("\(raw: detectedEnum.access) enum Meta: String, CaseIterable, Identifiable {")]

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

      DeclSyntax(nameProperty),
      DeclSyntax(idProperty),
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
    let cases = detectedEnum.casesList { item in
      "self = .\(item.name)"
    }

    return """
      \(raw: detectedEnum.access) init(_ \(parentParamName): \(raw: detectedEnum.parentTypeName)) {
        switch \(parentParamName) {
      \(raw: cases)
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
  private var metaCases: DeclSyntax {
    detectedEnum.cases
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
  var nameProperty: DeclSyntax {
    let cases = detectedEnum.casesList {
      "\"\($0.name.capitalized)\""
    }

    return
      """
      \(raw: detectedEnum.access) var name: String {
        switch self {
          \(raw: cases)
        }
      }
      """
  }

  var idProperty: DeclSyntax { "\(raw: detectedEnum.access) var id: String {rawValue}" }

  var hasAssociatedValuesProperty: DeclSyntax {
    let cases = detectedEnum.casesList {
      "\($0.hasAssociatedValues ? "true" : "false")"
    }

    return
      """
      \(raw: detectedEnum.access) var hasAssociatedValues: Bool {
        switch self {
          \(raw: cases)
        }
      }
      """
  }
}
