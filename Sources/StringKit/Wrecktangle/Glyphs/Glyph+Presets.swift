//
//  Glyph+Presets.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/11/2025.
//

extension Box.GlyphSet {
  //extension Box.GlyphResolved {

  static var thinJoins: Box.GlyphGroup {
    GlyphGroup {
      Glyph("┬", .join(.top))
      Glyph("┴", .join(.bottom))
      Glyph("├", .join(.leading))
      Glyph("┤", .join(.trailing))
      Glyph("┼", .join(.cross))
    }
  }

  //  static var boldSharpCorners: [Self] {
  //    [
  //            Glyph.corner(.increased, type: .topLeading): "┏",
  //            Glyph.corner(.increased, type: .topTrailing): "┓",
  //            Glyph.corner(.increased, type: .bottomLeading): "┗",
  //            Glyph.corner(.increased, type: .bottomTrailing): "┛",
  //    ]
  //  }

}
