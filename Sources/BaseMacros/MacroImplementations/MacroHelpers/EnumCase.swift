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

extension EnumCase {
  var name: String { identifier }

  var hasAssociatedValues: Bool {
    associatedValues != nil
//    _syntax.parameterClause != nil
  }

  var associatedValues: EnumCaseParameterClauseSyntax? {
    _syntax.parameterClause
  }
  
  var defaultValuesIfPresent: [InitializerClauseSyntax] {
    guard let assocValues = _syntax.parameterClause else { return [] }
    return assocValues.parameters.compactMap { $0.defaultValue }
  }
}
