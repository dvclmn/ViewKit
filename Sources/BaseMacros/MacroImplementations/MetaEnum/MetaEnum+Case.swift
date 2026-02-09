//
//  MetaEnum+Case.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 31/1/2026.
//

import MacroToolkit
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

//struct MetaEnumCase {
//  let enumCase: EnumCase
//}

//extension MetaEnumCase {

//  var name: String { enumCase.identifier }
//
//  var hasAssociatedValues: Bool {
//    enumCase._syntax.parameterClause != nil
//  }
//  
//  var defaultValueIfPresent: [InitializerClauseSyntax] {
//    guard let assocValues = enumCase._syntax.parameterClause else { return [] }
//    return assocValues.parameters.compactMap { $0.defaultValue }
//  }
//}

