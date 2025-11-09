//
//  GlyphSet+Hollow.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/11/2025.
//


extension Box.GlyphSet {
  
  public static let hollow = GlyphSet
  
  Self(
    style: .hollow,
    map: [
      Glyph(.horizontal, .standard, .hollow): "═",
      Glyph(.vertical, .standard, .hollow): "║",
      Glyph(.corner(.topLeading), .standard, .hollow): "╔",
      Glyph(.corner(.bottomTrailing), .standard, .hollow): "╝",
    ],
    fallback: SetRef(.sharp)
  )
}
