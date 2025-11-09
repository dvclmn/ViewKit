//
//  Builder+Glyph.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/11/2025.
//

@resultBuilder
enum GlyphBuilder {
  static func buildBlock(_ glyphs: Glyph...) -> [Glyph] { glyphs }
}

func roundedWeightyGlyphs(@GlyphBuilder _ content: () -> [Glyph]) -> [Character] {
  let set = Box.GlyphSets.rounded
  return content().map(set.resolve)
}


//@resultBuilder
//enum GlyphBuilder {
//  static func buildBlock(_ components: Box.GlyphDescriptor...) -> Box.GlyphMap {
//    Dictionary(uniqueKeysWithValues: components.map { ($0.type, $0) })
//  }
//  
//  static func buildArray(_ components: [Box.PartMap]) -> Box.PartMap {
//    components.reduce(into: [:]) { $0.merge($1) { _, new in new } }
//  }
//  
//  static func buildEither(first: Box.PartMap) -> Box.PartMap { first }
//  static func buildEither(second: Box.PartMap) -> Box.PartMap { second }
//  static func buildOptional(_ component: Box.PartMap?) -> Box.PartMap {
//    component ?? [:]
//  }
//}

//@resultBuilder
//enum GlyphBuilder {
//  static func buildBlock(_ components: any RowConvertible...) -> Box.GlyphStack {
//    components.map { $0.asGlyphRow() }
//  }
//  
//  static func buildEither(first: Box.GlyphStack) -> Box.GlyphStack { first }
//  static func buildEither(second: Box.GlyphStack) -> Box.GlyphStack { second }
//  
//  static func buildOptional(_ component: Box.GlyphStack?) -> Box.GlyphStack {
//    component ?? []
//  }
//}

