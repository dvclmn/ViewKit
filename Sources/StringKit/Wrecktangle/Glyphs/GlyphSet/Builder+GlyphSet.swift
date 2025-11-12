//
//  Builder+Glyph.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/11/2025.
//

@resultBuilder
enum GlyphSetBuilder {
  static func buildBlock(_ components: Box.GlyphMap...) -> Box.GlyphMap {
    Box.reduce(components)
  }

  static func buildExpression(_ expression: Glyph) -> Box.GlyphMap {
    [expression.descriptor: expression.character]
  }

}

extension GlyphSetBuilder {
  static func buildExpression(_ expression: Box.GlyphGroup) -> Box.GlyphMap {
    expression.map
  }

  static func buildExpression(_ expression: [Glyph]) -> Box.GlyphMap {
    Dictionary(
      uniqueKeysWithValues: expression.map {
        ($0.descriptor, $0.character)
      })
  }
}
