//
//  Values+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/2/2026.
//

import MacroToolkit
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

extension AssociatedValuesBuilder {
  package var cases: [EnumCase] { detectedEnum.cases }
  package var access: String { detectedEnum.accessLevel?.name ?? "" }

  /// This creates enumerated and v-prefixed variable names:
  /// ```
  /// var fernValue: Int? {
  ///   if case let .fern(v0) = self {
  ///     return v0
  ///   }
  ///   return nil
  /// }
  /// ```
  package func uniquedVariableNames(_ parameters: EnumCaseParameterListSyntax) -> DeclSyntax {

    DeclSyntax(
      parameters
        .enumerated()
        .map { index, _ in "v\(index)" }
        .joined(separator: ", ")

    )

  }
}

/// Note: a Case (not the whole enum itself)
struct AssociatedValuesCase {

}
