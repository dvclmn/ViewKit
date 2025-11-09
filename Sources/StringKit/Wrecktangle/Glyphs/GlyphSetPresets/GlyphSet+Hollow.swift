//
//  GlyphSet+Hollow.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/11/2025.
//

extension Box.GlyphSet {

  public static var hollow: Self {
    GlyphSet(.hollow, fallback: .sharp) {
      //      Self(
      //        style: .hollow,
      //        map: [
      Glyph("═", .horizontal)

      //      Glyph(.horizontal, .standard, .hollow): "═",
      Glyph("║", .vertical)
      Glyph("╔", .corner(.topLeading))
      Glyph("╝", .corner(.bottomTrailing))

    }

  }

}
