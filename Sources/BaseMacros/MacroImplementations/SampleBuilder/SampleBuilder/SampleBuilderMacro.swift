/*
 This source file is part of SwiftAndTipsMacros

 Copyright (c) 2023 Pedro Rojas and project authors
 Licensed under MIT License
*/

//
//  SampleBuilderMacro.swift
//
//
//  Created by Pedro Rojas on 05/08/23.
//

import BasePrimitives
import SwiftCompilerPlugin
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct SampleBuilderMacro: MemberMacro {

  public static func expansion(
    of node: SwiftSyntax.AttributeSyntax,
    providingMembersOf declaration: some SwiftSyntax.DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some SwiftSyntaxMacros.MacroExpansionContext
  ) throws -> [SwiftSyntax.DeclSyntax] {

    let numberOfItems = try getNumberOfItems(from: node)

    if numberOfItems <= 0 {
      SampleBuilderDiagnostic.report(
        diagnostic: .argumentNotGreaterThanZero,
        node: Syntax(declaration),
        context: context
      )
      return []
    }

    let generatorType = getDataGeneratorType(from: node)

    if let enumDecl = declaration.as(EnumDeclSyntax.self) {
      return SampleBuilderMacroForEnum(
        enumDecl: enumDecl,
        numberOfItems: numberOfItems,
        generatorType: generatorType,
        context: context
      )
    }

    if let structDecl = declaration.as(StructDeclSyntax.self) {
      return SampleBuilderMacroForStruct(
        structDecl: structDecl,
        numberOfItems: numberOfItems,
        generatorType: generatorType,
        context: context
      )
    }

    SampleBuilderDiagnostic.report(
      diagnostic: .notAnStructOrEnum,
      node: Syntax(declaration),
      context: context
    )
    return []
  }
}
