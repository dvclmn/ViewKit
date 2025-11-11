//
//  Row.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/11/2025.
//

import Foundation

// MARK: - Row Structure
struct Row {
  /// These are not descriptor, they're glyph structures
  let glyphs: [GlyphType]
  
  init(@RowBuilder _ content: () -> [GlyphType]) {
    self.glyphs = content()
  }
}

// MARK: - Row Convertible
protocol RowConvertible {
  func asGlyphRow() -> [GlyphType]
}

extension Array: RowConvertible where Element == GlyphType {
  func asGlyphRow() -> [GlyphType] { self }
}

extension Box.GlyphStructure: RowConvertible {
  func asGlyphRow() -> [GlyphType] { [self] }
}

extension Row: RowConvertible {
  func asGlyphRow() -> [GlyphType] { glyphs }
}


