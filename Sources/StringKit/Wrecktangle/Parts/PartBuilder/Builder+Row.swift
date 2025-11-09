//
//  Builder+Row.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/11/2025.
//

import Foundation

// MARK: - Part Builders


@resultBuilder
enum RowBuilder {
  static func buildBlock(_ components: [Glyph]...) -> [Glyph] {
    components.flatMap { $0 }
  }

  static func buildEither(first: [Glyph]) -> [Glyph] { first }
  static func buildEither(second: [Glyph]) -> [Glyph] { second }

  static func buildOptional(_ component: [Glyph]?) -> [Glyph] {
    component ?? []
  }
}

extension RowBuilder {
  static func buildExpression(_ expression: Glyph) -> [Glyph] {
    [expression]
  }
}
