//
//  Row.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/11/2025.
//

import Foundation

// MARK: - Row Structure
struct Row {
  let glyphs: [Glyph]
  
  init(@RowBuilder _ content: () -> [Glyph]) {
    self.glyphs = content()
  }
}

// MARK: - Row Convertible
protocol RowConvertible {
  func asGlyphRow() -> [Glyph]
}

extension Array: RowConvertible where Element == Glyph {
  func asGlyphRow() -> [Glyph] { self }
}

extension Box.GlyphDescriptor: RowConvertible {
  func asGlyphRow() -> [Glyph] { [self] }
}

extension Row: RowConvertible {
  func asGlyphRow() -> [Glyph] { glyphs }
}
