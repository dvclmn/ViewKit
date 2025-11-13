//
//  GlyphSet+Round.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/11/2025.
//

extension Box.GlyphSet {
  public static var rounded: Self {
    GlyphSet(.round) {

      Glyph("╭", .corner(.topLeading))
      Glyph("╮", .corner(.topTrailing))
      Glyph("╰", .corner(.bottomLeading))
      Glyph("╯", .corner(.bottomTrailing))

//      GlyphGroup.joinsThin
      GlyphGroup.straightsThin
//      GlyphGroup.straightsThin
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
