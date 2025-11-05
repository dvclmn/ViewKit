//
//  Row.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/11/2025.
//

import Foundation

// MARK: - Part Structures
struct Row {
  let glyphs: [Box.GlyphType]
  init(@RowBuilder _ content: () -> [Box.GlyphType]) {
    self.glyphs = content()
  }
}

extension Row: RowConvertible {
  func asGlyphRow() -> [Box.GlyphType] { glyphs }
}

