/*
 This source file is part of SwiftAndTipsMacros

 Copyright (c) 2023 Pedro Rojas and project authors
 Licensed under MIT License
*/

//
//  SampleBuilderItemMacro.swift
//
//
//  Created by Pedro Rojas on 23/08/23.
//

import SwiftCompilerPlugin
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

public struct SamplesIgnoredMacro: PeerMacro {

  public static func expansion(
    of node: SwiftSyntax.AttributeSyntax,
    providingPeersOf declaration: some SwiftSyntax.DeclSyntaxProtocol,
    in context: some SwiftSyntaxMacros.MacroExpansionContext
  ) throws -> [SwiftSyntax.DeclSyntax] {
    guard
      let variableDecl = declaration.as(VariableDeclSyntax.self),
      variableDecl.isStoredProperty
    else {
      SampleBuilderItemDiagnostic.report(
        diagnostic: .notAStoredProperty,
        node: node,
        context: context
      )
      return []
    }

    // Marker attribute; no generated peers needed.
    return []
  }

}
