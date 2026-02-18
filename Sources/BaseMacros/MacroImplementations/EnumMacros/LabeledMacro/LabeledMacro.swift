//
//  LabeledMacro.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/2/2026.
//

import MacroToolkit
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct LabeledMacro: MemberMacro {
  public static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {

    let builder = try LabeledBuilder(
      node: node,
      decl: declaration,
      context: context,
    )
    return try builder.build()
  }

}

extension LabeledMacro: ExtensionMacro {

  public static func expansion(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [ExtensionDeclSyntax] {

    guard let enumDecl = declaration as? EnumDeclSyntax else {
      throw MacroError("@Labeled can only be attached to enum declarations")
    }

    //    let isIdentifiable: Bool =
    //    declaration.inheritanceClause?.is(Identifiable.self)

    return try MacroHelpers.createConformanceForEnum(
      decl: enumDecl,
      protocol: "Identifiable"
    )
    //    return [try ExtensionDeclSyntax("extension \(type): Identifiable {}")]
  }
}
