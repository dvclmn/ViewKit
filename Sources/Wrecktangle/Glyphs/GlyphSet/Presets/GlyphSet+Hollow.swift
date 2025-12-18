//
//  GlyphSet+Hollow.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/11/2025.
//

extension Box.GlyphSet {

  public static var hollow: Self {
    GlyphSet(.hollow) {
      Glyph.blank
      Glyph("═", .horizontal, weight: .increased)
      Glyph("─", .horizontal)

      Glyph("║", .vertical, weight: .increased)
      Glyph("│", .vertical)

      Glyph("╤", .join(.top), x: .increased)
      Glyph("╧", .join(.bottom), x: .increased)
      Glyph("╟", .join(.leading), y: .increased)
      Glyph("╢", .join(.trailing), y: .increased)
      Glyph("┼", .join(.cross))

      Glyph("╔", .corner(.topLeading), weight: .increased)
      Glyph("╗", .corner(.topTrailing), weight: .increased)
      Glyph("╚", .corner(.bottomLeading), weight: .increased)
      Glyph("╝", .corner(.bottomTrailing), weight: .increased)
    }
  }
}
