//
//  GlyphGroup.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/11/2025.
//

typealias GlyphGroup = Box.GlyphGroup

extension Box {
  struct GlyphGroup: Mergable {

    var map: GlyphMap

    init(glyphs: GlyphMap) {
      self.map = glyphs
    }
    
    init(glyphs: GlyphMap) {
      self.map = glyphs
    }

    init(@GlyphGroupBuilder _ glyphs: () -> GlyphMap) {
      self.map = glyphs()
    }
  }
}

extension Box.GlyphGroup {
  
}

//extension Box.GlyphGroup {
//  func merged(with other: Box.GlyphGroup) -> Box.GlyphGroup {
//
//  }
//}

// MARK: - Glyph Builder
@resultBuilder
enum GlyphGroupBuilder {
  static func buildBlock(_ components: Box.GlyphMap...) -> Box.GlyphMap {
    Box.reduce(components)
  }

  static func buildExpression(_ expression: Glyph) -> Box.GlyphMap {
    [expression.descriptor: expression.character]
  }

  static func buildExpression(_ expression: [Glyph]) -> Box.GlyphMap {
    Dictionary(
      uniqueKeysWithValues: expression.map {
        ($0.descriptor, $0.character)
      })
  }
}
