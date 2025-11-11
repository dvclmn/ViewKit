//
//  GlyphSet+Sharp.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/11/2025.
//

extension Box.GlyphSet {

  public static var sharp: Self {
    GlyphSet(.sharp) {

      Glyph.blank

      GlyphGroup.straights
      GlyphGroup.joins
      GlyphGroup.corners

    }  // END set

  }  // END sharp preset

}
