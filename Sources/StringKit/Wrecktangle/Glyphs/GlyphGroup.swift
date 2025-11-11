//
//  GlyphGroup.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/11/2025.
//

typealias GlyphGroup = Box.GlyphGroup

extension Box {
  struct GlyphGroup {
    let glyphs: GlyphMap
    
    init(glyphs: GlyphMap) {
      self.glyphs = glyphs
    }
    
    init(@GlyphGroupBuilder _ glyphs: () -> GlyphMap) {
      self.glyphs = glyphs()
    }
    
  }
}

@resultBuilder
enum GlyphGroupBuilder {
  static func buildBlock(_ components: Box.GlyphMap...) -> Box.GlyphMap {
    Box.reduce(components)
  }
  
  static func buildExpression(_ expression: Glyph) -> Box.GlyphMap {
    [expression.descriptor: expression.character]
  }
  
  static func buildExpression(_ expression: [Glyph]) -> Box.GlyphMap {
    Dictionary(uniqueKeysWithValues: expression.map {
      ($0.descriptor, $0.character)
    })
  }
}
