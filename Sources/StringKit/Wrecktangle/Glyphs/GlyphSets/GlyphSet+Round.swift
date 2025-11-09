//
//  GlyphSet+Round.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/11/2025.
//

extension Box.GlyphSet {
//  wqdqkqef
  public static var rounded: Self {
    GlyphSet(.rounded) {
      Glyph(<#T##character: Character##Character#>, <#T##role: Box.GlyphDescriptor.Role##Box.GlyphDescriptor.Role#>, weight: <#T##Box.GlyphDescriptor.Prominence#>, design: <#T##Box.GlyphDescriptor.Design#>)
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
