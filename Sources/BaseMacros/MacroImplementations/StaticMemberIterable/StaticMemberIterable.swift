//
//  StaticMemberIterable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 29/12/2025.
//

import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

// Full credit to Daniel Sincere for this
// `StaticMemberIterable` macro:
// https://github.com/DanielSincere/StaticMemberIterable
public struct StaticMemberIterableMacro: MemberMacro {
  public static func expansion(
    of node: AttributeSyntax,
    providingMembersOf declaration: some DeclGroupSyntax,
    conformingTo protocols: [TypeSyntax],
    in context: some MacroExpansionContext
  ) throws -> [DeclSyntax] {
    
    let builder = StaticMemberIterableBuilder(decl: declaration)
    return builder.build()
  }
}
