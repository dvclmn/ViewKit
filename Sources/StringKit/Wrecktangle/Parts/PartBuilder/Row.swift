//
//  Row.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/11/2025.
//

import Foundation

// MARK: - Row Structure
struct Row {
  let glyphs: [Box.GlyphType]
  init(@RowBuilder _ content: () -> [Box.GlyphType]) {
    self.glyphs = content()
  }
}

// MARK: - Row Convertible
protocol RowConvertible {
  func asGlyphRow() -> [Box.GlyphType]
}

extension Array: RowConvertible where Element == Box.GlyphType {
  func asGlyphRow() -> [Box.GlyphType] { self }
}

extension Box.GlyphType: RowConvertible {
  func asGlyphRow() -> [Box.GlyphType] { [self] }
}

extension Row: RowConvertible {
  func asGlyphRow() -> [Box.GlyphType] { glyphs }
}
