//
//  Builder+Glyph.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/11/2025.
//

@resultBuilder
enum GlyphSetBuilder {

  
  static func buildBlock(_ components: Box.GlyphMap...) -> Box.GlyphMap {
    
    // Simple explicit merge: last-wins or first-wins
    components.reduce(into: [:]) { dict, component in
      for (key, design) in component {
        dict[key] = design // override if exists
      }
    }
//    components.merged(keeping: .first)
    //    Box.reduce(components)
  }

//  static func buildExpression(_ expression: Glyph) -> Box.GlyphMap {
//    [expression.descriptor: expression.character]
//  }

}

extension GlyphSetBuilder {
  
  static func buildExpression(_ glyph: Glyph) -> Box.GlyphMap {
    let key = Box.GlyphKey(role: glyph.descriptor.structure.role,
                       weight: glyph.descriptor.structure.weight)
    return [key: glyph.descriptor.design]
  }
  
  static func buildExpression(_ glyphs: [Glyph]) -> Box.GlyphMap {
    glyphs.reduce(into: [:]) { dict, glyph in
      let key = Box.GlyphKey(role: glyph.descriptor.structure.role,
                         weight: glyph.descriptor.structure.weight)
      dict[key] = glyph.descriptor.design
    }
  }
  
  static func buildExpression(_ group: Box.GlyphGroup) -> Box.GlyphMap {
    group.map
  }

  
  
//  static func buildExpression(_ expression: Box.GlyphGroup) -> Box.GlyphMap {
//    expression.map
//  }
//
//  static func buildExpression(_ expression: [Glyph]) -> Box.GlyphMap {
//    Dictionary(
//      uniqueKeysWithValues: expression.map {
//        ($0.descriptor, $0.character)
//      })
//  }
}
