//
//  SyntaxResultBuilder.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/10/2025.
//

import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

@resultBuilder
struct DeclSyntaxBuilder {
  static func buildBlock(_ components: [DeclSyntax]...) -> [DeclSyntax] {
    components.flatMap { $0 }
  }

  static func buildArray(_ components: [[DeclSyntax]]) -> [DeclSyntax] {
    components.flatMap { $0 }
  }

  static func buildOptional(_ component: [DeclSyntax]?) -> [DeclSyntax] {
    component ?? []
  }

  static func buildEither(first component: [DeclSyntax]) -> [DeclSyntax] {
    component
  }

  static func buildEither(second component: [DeclSyntax]) -> [DeclSyntax] {
    component
  }

  static func buildExpression(_ expression: DeclSyntax) -> [DeclSyntax] {
    [expression]
  }

  static func buildExpression(_ expression: [DeclSyntax]) -> [DeclSyntax] {
    expression
  }
}
