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

struct MetaEnumCase {
  let childCase: EnumCase
}

extension MetaEnumCase {
  var name: String { childCase.identifier }
  
  var hasAssociatedValues: Bool {
    childCase._syntax.parameterClause != nil
  }
}
