//
//  Builder+Glyph.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/11/2025.
//

@resultBuilder
enum GlyphSetBuilder {
  static func buildBlock(_ glyphs: Glyph...) -> Box.GlyphMap {
    Dictionary(
      uniqueKeysWithValues: glyphs.map {
        ($0.descriptor, $0.character)
      }
    )
  }
}
