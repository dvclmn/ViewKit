//
//  MetaEnumCase.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 31/1/2026.
//

import MacroToolkit
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

struct MetaEnumBuilder {
  let detectedEnum: Enum
  let parentParamName: TokenSyntax
  let caseDetection: [DeclSyntax]
  //  let caseDetection: CaseDetectionBuilder

  init(
    node: AttributeSyntax,
    decl: some DeclGroupSyntax,
    context: some MacroExpansionContext,
  ) throws {

    guard let enumDecl = decl as? EnumDeclSyntax else {
      throw MacroError("@MetaEnum can only be attached to enum declarations")
    }
    self.detectedEnum = Enum(enumDecl)

    self.caseDetection = try CaseDetectionBuilder(
      node: node,
      decl: decl
    ).build()

    self.parentParamName = context.makeUniqueName("parent")
  }
}
