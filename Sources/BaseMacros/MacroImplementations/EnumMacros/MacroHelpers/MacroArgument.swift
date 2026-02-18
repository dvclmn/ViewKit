//
//  MacroArgument.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/10/2025.
//

import MacroToolkit
import SwiftSyntax
import SwiftSyntaxMacros

extension AttributeSyntax {

  /// Uses MacroToolKit, returns bool value for a Macro attribute if present.
  /// Such as `@CaseDetection(includesNames: true)`
  public func boolArgument(labeled label: String) -> Bool {
    let argument = MacroAttribute(self).argument(labeled: label)?.asBooleanLiteral
    return argument?.value ?? false
  }
}
