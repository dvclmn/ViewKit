//
//  Thing.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/11/2025.
//

import Foundation

// MARK: - Part Builders
@resultBuilder
enum RowBuilder {
  static func buildBlock(
    _ components: Box.GlyphType...
  ) -> [Box.GlyphType] {
    components
  }
}

@resultBuilder
enum GlyphStackBuilder {
  static func buildBlock(
    _ components: any GlyphRowConvertible...
  ) -> [[Box.GlyphType]] {
    components.map { $0.asGlyphRow() }
  }
}

// MARK: - Part Structures
struct Row {
  let glyphs: [Box.GlyphType]
  init(@RowBuilder _ content: () -> [Box.GlyphType]) {
    self.glyphs = content()
  }
}

func GlyphGrid(
  @GlyphStackBuilder _ content: () -> [[Box.GlyphType]]
) -> [[Box.GlyphType]] {
  content()
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
