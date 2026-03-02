//
//  GlyphSet+Round.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/11/2025.
//

extension Box.GlyphSet {
  public static var rounded: Self {
    GlyphSet(.round) {

      Glyph.blank

      // Rounded box glyphs are all thin in Unicode, so we alias
      // increased weights to the same characters.
      Glyph("─", .horizontal, weight: .increased)
      Glyph("│", .vertical, weight: .increased)

      Glyph("╭", .corner(.topLeading))
      Glyph("╮", .corner(.topTrailing))
      Glyph("╰", .corner(.bottomLeading))
      Glyph("╯", .corner(.bottomTrailing))

      Glyph("╭", .corner(.topLeading), weight: .increased)
      Glyph("╮", .corner(.topTrailing), weight: .increased)
      Glyph("╰", .corner(.bottomLeading), weight: .increased)
      Glyph("╯", .corner(.bottomTrailing), weight: .increased)

      GlyphGroup.joinsThin
      Glyph("┬", .join(.top), x: .increased)
      Glyph("┴", .join(.bottom), x: .increased)
      Glyph("├", .join(.leading), y: .increased)
      Glyph("┤", .join(.trailing), y: .increased)
      Glyph("┼", .join(.cross), y: .increased)

      GlyphGroup.straightsThin
    }
  }
  //    style: .rounded,
  //    map: [
  //      Glyph(.corner(.topLeading), .standard, .rounded): "╭",
  //      Glyph(.corner(.bottomTrailing), .standard, .rounded): "╯",
  //      // NB: Rounded box drawing chars are all light; no increased-weight variants exist.
  //    ],
  //    fallback: SetRef(.sharp)  // fallback to sharp for anything not covered
  //  )

}

extension Box.GlyphMap {

}
