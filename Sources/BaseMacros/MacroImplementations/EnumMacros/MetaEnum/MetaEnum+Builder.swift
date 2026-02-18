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

extension MetaEnumBuilder {
  
  func build() -> [DeclSyntax] {
    [
      /// Properties on Parent
      DeclSyntax("\(raw: detectedEnum.access) var meta: Self.Meta {.init(self)}"),
      DeclSyntax(hasAssociatedValuesProperty),
      DeclSyntax(metaToParentInit),
    ]
    
    /// Beginning of Meta enum declaration
    + [
      DeclSyntax(
        "\(raw: detectedEnum.access) enum Meta: String, CaseIterable, Identifiable, Hashable, MetaEnumNested {"
      )
    ]
    
    + metaEnumInternals
    + caseDetection
    
    /// End brace for Meta enum
    + [DeclSyntax("}")]
    
  }

}
