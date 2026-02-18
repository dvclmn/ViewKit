//
//  Labeled+Builder.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/2/2026.
//

import MacroToolkit
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

struct LabeledBuilder {
  let detectedEnum: Enum

  init(
    node: AttributeSyntax,
    decl: some DeclGroupSyntax,
    context: some MacroExpansionContext
  ) throws {
    self.detectedEnum = try LabeledHelpers.detectEnum(in: decl)
  }
}
