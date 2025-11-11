//
//  GlyphGroup.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/11/2025.
//

typealias GlyphGroup = Box.GlyphGroup

extension Box {
  struct GlyphGroup {
//    let design: GlyphDesign
//    let role: GlyphRole
    let glyphs: GlyphMap
    
    init(
//      design: GlyphDesign,
//      role: GlyphRole,
      glyphs: GlyphMap
    ) {
//      self.design = design
//      self.role = role
      self.glyphs = glyphs
    }
    
    init(
//      design: GlyphDesign,
//      _ role: GlyphRole,
      @GlyphGroupBuilder _ glyphs: () -> GlyphMap
    ) {
//      self.design = design
//      self.role = role
      self.glyphs = glyphs()
    }
    
  }
}


@resultBuilder
enum GlyphGroupBuilder {
  static func buildBlock(_ components: Box.GlyphMap...) -> Box.GlyphMap {
    Box.reduce(components)
//    components.reduce(into: [:]) { $0.merge($1) { _, new in new } }
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
