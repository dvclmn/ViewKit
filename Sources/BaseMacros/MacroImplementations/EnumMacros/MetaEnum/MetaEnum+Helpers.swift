//
//  MetaEnumHelpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/10/2025.
//

import MacroToolkit
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

extension MetaEnumBuilder {

  var metaEnumInternals: [DeclSyntax] {
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
    let cases = detectedEnum.casesList(
      .switchCase { item in
        "self = .\(item.name)"
      }
    )

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
    let cases = detectedEnum.casesList(
      .switchCase {
        "\"\($0.name.capitalized)\""
      }
    )

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
    let cases = detectedEnum.casesList(
      .switchCase {
        "\($0.hasAssociatedValues ? "true" : "false")"
      }
    )
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
