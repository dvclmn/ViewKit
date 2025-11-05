//
//  RowConvertible.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/11/2025.
//


// MARK: - Glyph Row Conversion
protocol RowConvertible {
  func asGlyphRow() -> [Box.GlyphType]
}

extension Array: RowConvertible where Element == Box.GlyphType {
  func asGlyphRow() -> [Box.GlyphType] { self }
}

extension Box.GlyphType: RowConvertible {
  func asGlyphRow() -> [Box.GlyphType] { [self] }
}
