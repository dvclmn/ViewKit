//
//  LabeledIconMacro.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/2/2026.
//

import MacroToolkit
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

enum LabelIconValue {
  case symbol(String)
  case emoji(String)
}

public struct LabeledIconMacro: PeerMacro {

  public static func expansion(
    of node: SwiftSyntax.AttributeSyntax,
    providingPeersOf declaration: some SwiftSyntax.DeclSyntaxProtocol,
    in context: some SwiftSyntaxMacros.MacroExpansionContext
  ) throws -> [SwiftSyntax.DeclSyntax] {

    let icon = getIcon(from: node)

    guard let enumCase = declaration.as(EnumCaseDeclSyntax.self) else {
      throw MacroError("@Icon can only be attached to an enum case")
    }

    _ = icon
    _ = enumCase

    /// Ultimately this returns nothing, but trying to get the kind of
    /// icon defined by the user, attached to an enum case, such as
    /// `@Icon(.symbol("tray.fill")) case tray`
    return []
  }

  /// Extracts the icon argument from `@Icon(...)`.
  static func getIcon(from node: AttributeSyntax) -> LabelIconValue {
    guard let firstArg = node.arguments?.as(LabeledExprListSyntax.self)?.first else {
      fatalError("Compiler bug: Argument must exist")
    }

    let expr = firstArg.expression

    if let call = expr.as(FunctionCallExprSyntax.self),
      let member = call.calledExpression.as(MemberAccessExprSyntax.self)
    {
      let baseName = member.declName.baseName.text
      if let valueExpr = call.arguments.first?.expression,
        let string = valueExpr.as(StringLiteralExprSyntax.self)?.segments.compactMap({ seg in
          seg.as(StringSegmentSyntax.self)?.content.text
        }).joined()
      {
        if baseName == "symbol" { return .symbol(string) }
        if baseName == "emoji" { return .emoji(string) }
      }
    }

    if let stringLiteral = expr.as(StringLiteralExprSyntax.self) {
      let value = stringLiteral.segments.compactMap { $0.as(StringSegmentSyntax.self)?.content.text }.joined()
      return .symbol(value)
    }

    fatalError("Unsupported @Icon argument. Use .symbol(\"...\"), .emoji(\"...\"), or a string literal.")
  }
}
