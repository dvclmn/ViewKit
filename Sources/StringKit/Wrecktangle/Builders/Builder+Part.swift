//
//  Thing.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/11/2025.
//

import Foundation


@resultBuilder
enum PartBuilder {
  static func buildBlock(
    _ components: any GlyphRowConvertible...
  ) -> Box.GlyphStack {
    components.map { $0.asGlyphRow() }
  }
  
//  static func buildEither(
//    first components: any GlyphRowConvertible...
//  ) -> Box.GlyphStack {
//    components.map { $0.asGlyphRow() }
//  }
//  
//  static func buildEither(
//    second components: any GlyphRowConvertible...
//  ) -> Box.GlyphStack {
//    components.map { $0.asGlyphRow() }
//  }
}

// MARK: - Part Structures
struct Row {
  let glyphs: [Box.GlyphType]
  init(@RowBuilder _ content: () -> [Box.GlyphType]) {
    self.glyphs = content()
  }
}

// MARK: - Glyph Row Conversion
protocol GlyphRowConvertible {
  func asGlyphRow() -> [Box.GlyphType]
}

extension Row: GlyphRowConvertible {
  func asGlyphRow() -> [Box.GlyphType] { glyphs }
}

extension Array: GlyphRowConvertible where Element == Box.GlyphType {
  func asGlyphRow() -> [Box.GlyphType] { self }
}

extension Box.GlyphType: GlyphRowConvertible {
  func asGlyphRow() -> [Box.GlyphType] { [self] }
}
