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

//  static func buildArray(_ glyphs: [Glyph]) -> Box.GlyphMap {
//    Dictionary(
//      uniqueKeysWithValues: glyphs.map {
//        ($0.descriptor, $0.character)
//      }
//    )
////    glyphs.reduce(into: [:]) { $0.merge($1) { _, new in new } }
//  }
  
//  static func buildArray(_ glyphs: [Box.GlyphMap]) -> Box.GlyphMap {
//    glyphs.reduce(into: [:]) { $0.merge($1) { _, new in new } }
//  }

}
extension GlyphSetBuilder {
  static func buildExpression(_ expression: [Glyph]) -> Box.GlyphMap {
    Dictionary(
      uniqueKeysWithValues: expression.map {
        ($0.descriptor, $0.character)
      }
    )
//    [expression]
  }
  //  static func buildExpression(_ expression: [Glyph]) -> Box.GlyphMap {
  //    expression.flatMap { glyph in
  //      Dictionary(
  //        uniqueKeysWithValues: glyphs.map {
  //          ($0.descriptor, $0.character)
  //        }
  //      )
  //    }
  //  }
}
