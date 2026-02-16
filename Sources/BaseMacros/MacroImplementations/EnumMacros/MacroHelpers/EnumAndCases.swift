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
  /// // In a switch body:
  /// let lines = casesList(preset: .switchCase { _ in "someValue" })
  ///
  /// // For arrays/OptionSet literals:
  /// let lines = memberList
  /// ```
  ///
  /// *Incorrect* usage:
  /// ```
  /// enum SomeEnum {
  ///   case whale
  ///   // ...
  ///
  /// ```
  /// Returns a joined string built from each enum case using a custom formatter.
  /// - Parameter valueForCase: A closure that returns a string for each case.
  /// - Returns: The joined string with a newline separator.
//  func casesList(_ valueForCase: (EnumCase) -> String) -> String {
//    cases
//      .map { valueForCase($0) }
//      .joined(separator: "\n")
//  }

  /// Returns a joined string using a provided preset.
  /// - Parameter preset: A built-in formatting preset for common patterns.
  /// - Returns: The joined string with a newline separator.
  func casesList(_ preset: EnumCasesPreset) -> String {
    switch preset {
      case .switchCase(let valueExpression):
        /// Produces lines like: `case .foo: <valueExpression>`
        cases
          .map { "case .\($0.name): \(valueExpression($0))" }
          .joined(separator: "\n")

      case .memberList(let trailing):
        /// Produces lines like: `.foo<trailing>`
        cases
          .map { ".\($0.name)\(trailing)" }
          .joined(separator: "\n")
    }
  }

  /// Convenience: Default to a member list suitable for array/OptionSet literals.
  /// Produces lines like: ".foo,"
//  var memberList: String {
//    casesList(preset: .memberList(trailing: ","))
//  }

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

public enum EnumCasesPreset {
  /// Use inside switch bodies. Provide a value expression to place after the colon.
  /// Example line: `case .foo: someValue`.
  case switchCase((EnumCase) -> String)
  /// Use for building simple member references, e.g., in array/OptionSet literals.
  /// Example line: `.foo,` where `trailing` could be a comma or empty string.
  case memberList(trailing: String)
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
