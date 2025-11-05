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

extension Box {
  struct Part {
    let theme: Theme
    let glyphs: GlyphStack

    var width: Int { glyphs.width }
    var stringValue: String { glyphs.toStringStack(with: theme).string }

    init(
      theme: Theme,
      @GlyphStackBuilder _ content: () -> [[Box.GlyphType]]
    ) {
      self.theme = theme
      self.glyphs = content()
    }
  }
}

func Part(@GlyphStackBuilder _ content: () -> [[Box.GlyphType]]) -> Box.GlyphStack {
  Box.Part(theme: .default, content).glyphs
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
