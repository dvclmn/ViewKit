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

  /// Creates enumerated and v-prefixed variable names for pattern matching
  /// ```
  /// var fernValue: Int? {
  ///   if case let .fern(v0) = self {
  ///     return v0
  ///   }
  ///   return nil
  /// }
  /// ```
  
  /// e.g., "v0" or "v0, v1, v2"
//  package func uniquedVariableNames(_ parameters: EnumCaseParameterListSyntax) -> String {
//    parameters
//      .enumerated()
//      .map { index, _ in "v\(index)" }
//      .joined(separator: ", ")
//  }
//  package func uniquedVariableNames(_ parameters: EnumCaseParameterListSyntax) -> DeclSyntax {
//
//    DeclSyntax(
//      parameters
//        .enumerated()
//        .map { index, _ in "v\(index)" }
//        .joined(separator: ", ")
//
//    )
//
//  }
}

/// Note: a Case (not the whole enum itself)
struct AssociatedValuesCase {

}
