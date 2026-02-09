//
//  EnumCase.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/2/2026.
//

import MacroToolkit
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

extension Enum {
  /// Public, internal, etc.
  var access: String { accessLevel?.name ?? "" }

  /// Returns the name of the enum the macro is attached to.
  ///
  /// E.g. the result for the below is `AnotherEnum`.
  /// ```
  /// @MetaEnum
  /// enum AnotherEnum {...}
  /// ```
  var parentTypeName: String { identifier }

  /// Can probably phase this out
  @available(*, deprecated, renamed: "cases", message: "Prefer more clearly named `cases` instead")
  var childCases: [EnumCase] { cases }

  var hasAnyAssociatedValues: Bool {
    cases.contains(where: \.hasAssociatedValues)
  }

  /// For usage when listing out cases within properties —
  /// not for the original declarations of cases.
  ///
  /// Correct usage:
  /// ```
  /// var someProperty: Bool {
  ///   case .whale: someValue
  ///   // ...
  ///
  /// ```
  ///
  /// *Incorrect* usage:
  /// ```
  /// enum SomeEnum {
  ///   case whale
  ///   // ...
  ///
  /// ```
  func casesList(_ valueForCase: (EnumCase) -> String) -> String {
    cases
      .map { "case .\($0.name): \(valueForCase($0))" }
      .joined(separator: "\n")
  }

  /// Common Swift declaration modifiers include:
  /// - Access control: public, internal, fileprivate, private, package, open
  /// - Behavior/semantics: final, static, class, override, mutating, nonmutating, required, convenience, dynamic
  /// - Concurrency and availability: async, rethrows (for functions), @available is an attribute (not a modifier), but it often appears in a similar place
  /// - Actor isolation: nonisolated
  /// - Inheritance control: open (for classes and class members)
    var modifiers: DeclModifierListSyntax {
      _syntax.modifiers
    }
}

extension EnumCase {

  var name: String { identifier }

  var hasAssociatedValues: Bool { associatedValues != nil }

  var associatedValues: EnumCaseParameterClauseSyntax? {
    _syntax.parameterClause
  }

  var defaultValuesIfPresent: [InitializerClauseSyntax] {
    guard let assocValues = _syntax.parameterClause else { return [] }
    return assocValues.parameters.compactMap { $0.defaultValue }
  }
}
