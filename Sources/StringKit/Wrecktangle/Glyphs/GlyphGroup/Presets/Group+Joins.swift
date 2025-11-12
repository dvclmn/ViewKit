//
//  Group+Joins.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/11/2025.
//

extension Box.GlyphGroup {
 
  // MARK: - All Joins
  static var joins: Self {
    joinsThick
      .merged(with: joinsThickExtThinInt)
      .merged(with: joinsThin)
  }
  
  // MARK: - Thin Joins
  static var joinsThin: Self {
    GlyphGroup {
      Glyph("┬", .join(.top))
      Glyph("┴", .join(.bottom))
      Glyph("├", .join(.leading))
      Glyph("┤", .join(.trailing))
      Glyph("┼", .join(.cross))
    }
  }
  
  // MARK: - Bold Joins
  static var joinsThick: Self {
    GlyphGroup {
      Glyph("┳", .join(.top), x: .increased, y: .increased)
      Glyph("┻", .join(.bottom), x: .increased, y: .increased)
      Glyph("┣", .join(.leading), x: .increased, y: .increased)
      Glyph("┫", .join(.trailing), x: .increased, y: .increased)
      Glyph("╋", .join(.cross), x: .increased, y: .increased)
    }
  }
  
  // MARK: - Bold exterior, Thin interior Joins
  static var joinsThickExtThinInt: Box.GlyphGroup {
    GlyphGroup {
      Glyph("┯", .join(.top), x: .increased)
      Glyph("┷", .join(.bottom), x: .increased)
      Glyph("┠", .join(.leading), y: .increased)
      Glyph("┨", .join(.trailing), y: .increased)
      Glyph("╂", .join(.cross), y: .increased)
    }
  }
}
