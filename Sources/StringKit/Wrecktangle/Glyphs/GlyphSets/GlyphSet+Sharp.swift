//
//  GlyphSet+Sharp.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/11/2025.
//

extension Box.GlyphSet {
  
  public static let sharp = Self(
    style: .sharp,
    map: [
      Glyph(.horizontal, .standard, .sharp): "─",
      Glyph(.horizontal, .increased, .sharp): "━",
      Glyph(.corner(.topLeading), .standard, .sharp): "┌",
      Glyph(.corner(.bottomTrailing), .standard, .sharp): "┘",
    ]
  )

  
}
