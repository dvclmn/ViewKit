//
//  GlyphSet+Hollow.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/11/2025.
//

extension Box.GlyphSet {

  public static var hollow: Self {
    GlyphSet(.hollow, fallback: .sharp) {
      
      Glyph("═", .horizontal)
      Glyph("─", .horizontal)
      
      Glyph("║", .vertical)
      Glyph("│", .vertical)
      
      
      
      Glyph("╤", .join(.top), x: .increased)
      Glyph("╧", .join(.bottom), x: .increased)
      Glyph("╟", .join(.leading), y: .increased)
      Glyph("╢", .join(.trailing), y: .increased)
      Glyph("┼", .join(.cross), x: .increased)
      
      Glyph("╔", .corner(.topLeading), weight: .increased)
      Glyph("╗", .corner(.topTrailing))
      Glyph("╚", .corner(.bottomLeading))
      Glyph("╝", .corner(.bottomTrailing), weight: .increased)
      
      
//      Glyph.corner(.increased, type: .topLeading): "╔",
//      Glyph.corner(.increased, type: .bottomTrailing): "╝",


    }

  }

}
