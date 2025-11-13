//
//  Builder+Glyph.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/11/2025.
//

@resultBuilder
enum GlyphSetBuilder {

  static func buildBlock(_ components: Box.GlyphMap...) -> Box.GlyphMap {

    /// Simple explicit merge: last-wins or first-wins
    components.reduce(into: [:]) { dict, component in
      for (key, glyph) in component {
        /// override if exists
        dict[key] = glyph
      }
    }
  }
}

extension GlyphSetBuilder {

  static func buildExpression(_ glyph: Glyph) -> Box.GlyphMap {
    let key = Box.GlyphKey(
      role: glyph.descriptor.structure.role,
      weight: glyph.descriptor.structure.weight)
    return [key: glyph]
  }

  static func buildExpression(_ glyphs: [Glyph]) -> Box.GlyphMap {
    glyphs.reduce(into: [:]) { dict, glyph in
      let key = Box.GlyphKey(
        role: glyph.descriptor.structure.role,
        weight: glyph.descriptor.structure.weight)
      dict[key] = glyph
    }
  }

  static func buildExpression(_ group: Box.GlyphGroup) -> Box.GlyphMap {
    group.map
  }
}
