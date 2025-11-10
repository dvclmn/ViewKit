//
//  GlyphSet+Sharp.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/11/2025.
//

extension Box.GlyphSet {

  public static var sharp: Self {
//    GlyphSet {
    GlyphSet(.sharp) {

      Glyph.blank

      // MARK: - Horizontal
      Glyph("━", .horizontal, weight: .increased)
      Glyph("─", .horizontal)

      // MARK: - Vertical
      Glyph("┃", .vertical, weight: .increased)
      Glyph("│", .vertical)

      // MARK: - Bold exterior, Thin interior Joins
      Glyph("┯", .join(.top), x: .increased)
      Glyph("┷", .join(.bottom), x: .increased)
      Glyph("┠", .join(.leading), y: .increased)
      Glyph("┨", .join(.trailing), y: .increased)
      Glyph("╂", .join(.cross), y: .increased)

      // MARK: - Bold Joins
      Glyph("┳", .join(.top), x: .increased, y: .increased)
      Glyph("┻", .join(.bottom), x: .increased, y: .increased)
      Glyph("┣", .join(.leading), x: .increased, y: .increased)
      Glyph("┫", .join(.trailing), x: .increased, y: .increased)
      Glyph("╋", .join(.cross), x: .increased, y: .increased)

      // MARK: - Thin Joins
      Glyph("┬", .join(.top))
      Glyph("┴", .join(.bottom))
      Glyph("├", .join(.leading))
      Glyph("┤", .join(.trailing))
      Glyph("┼", .join(.cross))

      // MARK: - Bold Corners
      Glyph("┏", .corner(.topLeading), weight: .increased)
      Glyph("┓", .corner(.topTrailing), weight: .increased)
      Glyph("┗", .corner(.bottomLeading), weight: .increased)
      Glyph("┛", .corner(.bottomTrailing), weight: .increased)

      // MARK: - Thin Corners
      Glyph("┌", .corner(.topLeading))
      Glyph("┐", .corner(.topTrailing))
      Glyph("└", .corner(.bottomLeading))
      Glyph("┘", .corner(.bottomTrailing))
    }  // END set

  }  // END sharp preset

}
