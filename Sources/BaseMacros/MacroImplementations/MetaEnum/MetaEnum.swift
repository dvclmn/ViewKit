//
//  MetaEnum.swift
//  BaseMacros
//
//  Created by Dave Coleman on 18/9/2025.
//

//===----------------------------------------------------------------------===//
//
// This source file is part of the Swift.org open source project
//
// Copyright (c) 2014 - 2023 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
//===----------------------------------------------------------------------===//

import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import MacroToolkit

public struct MetaEnumMacro: MemberMacro, ExtensionMacro {
  public static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {

    let metaEnumBuilder = try MetaEnumBuilder(
      node: node,
      decl: declaration,
      context: context,
    )
 
    return metaEnumBuilder.build()
  }

  public static func expansion(
    of node: AttributeSyntax,
    attachedTo declaration: some DeclGroupSyntax,
    providingExtensionsOf type: some TypeSyntaxProtocol,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [ExtensionDeclSyntax] {
    
    []
//    let builder = try MetaEnumBuilder(
//      node: node,
//      decl: declaration,
//      context: context
//    )
//    let parentType = builder.parentTypeName
////    let ext: ExtensionDeclSyntax
////    let ext: DeclSyntax = "extension \(raw: parentType): MetaEnumProtocol {}"
//    
////    return [ext]
//    return [
//      try ExtensionDeclSyntax("extension \(type): \(raw: parentType) {}"),
//    ]
    
    
  }
}
