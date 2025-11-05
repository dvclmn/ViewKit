//
//  RowConvertible.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/11/2025.
//

protocol RowConvertible {
  func asGlyphRow() -> [Box.GlyphType]
}

extension Array: RowConvertible where Element == Box.GlyphType {
  func asGlyphRow() -> [Box.GlyphType] { self }
}

extension Box.GlyphType: RowConvertible {
  func asGlyphRow() -> [Box.GlyphType] { [self] }
}
