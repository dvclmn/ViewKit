//
//  Row.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/11/2025.
//

import Foundation

// MARK: - Row Structure
struct Row {
  let glyphDescriptors: [GlyphType]
  
  init(@RowBuilder _ content: () -> [GlyphType]) {
    self.glyphDescriptors = content()
  }
}

// MARK: - Row Convertible
protocol RowConvertible {
  func asGlyphRow() -> [GlyphType]
}

extension Array: RowConvertible where Element == GlyphType {
  func asGlyphRow() -> [GlyphType] { self }
}

extension Box.GlyphType: RowConvertible {
  func asGlyphRow() -> [GlyphType] { [self] }
}

extension Row: RowConvertible {
  func asGlyphRow() -> [GlyphType] { glyphDescriptors }
}


