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

    let access
    let staticMemberNames: [String] = declaration.memberBlock.members
      .flatMap { (memberDeclListItemSyntax: MemberBlockItemSyntax) in
        memberDeclListItemSyntax
          .children(viewMode: .fixedUp)
          .compactMap({ $0.as(VariableDeclSyntax.self) })
      }
      .compactMap { (variableDeclSyntax: VariableDeclSyntax) in
        guard variableDeclSyntax.hasStaticModifier else {
          return nil
        }
        return variableDeclSyntax.bindings
          .compactMap { (patternBindingSyntax: PatternBindingSyntax) in
            patternBindingSyntax.pattern.as(IdentifierPatternSyntax.self)?.identifier.text
          }
          .first
      }
    return ["static let allStaticMembers = [\(raw: staticMemberNames.joined(separator: ", "))]"]
  }
}

extension VariableDeclSyntax {
  fileprivate var hasStaticModifier: Bool {
    modifiers.children(viewMode: .fixedUp)
      .compactMap { syntax in
        syntax.as(DeclModifierSyntax.self)?
          .children(viewMode: .fixedUp)
          .contains { syntax in
            switch syntax.as(TokenSyntax.self)?.tokenKind {
              case .keyword(.static):
                return true
              default:
                return false
            }
          }
      }
      .contains(true)
  }
}
