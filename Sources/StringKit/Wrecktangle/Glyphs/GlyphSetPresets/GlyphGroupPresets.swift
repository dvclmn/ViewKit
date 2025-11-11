//
//  Glyph+Presets.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/11/2025.
//

extension Box.GlyphGroup {

  //  static var straights: Self {
  //    GlyphGroup {
  //      // MARK: - Horizontal
  //      Glyph("━", .horizontal, weight: .increased)
  //      Glyph("─", .horizontal)
  //
  //      // MARK: - Vertical
  //      Glyph("┃", .vertical, weight: .increased)
  //      Glyph("│", .vertical)
  //
  //    }
  //  }

  static var straights: Self {
    straightsThin.merged(with: straightsThick)
  }

  static var straightsThick: Self {
    GlyphGroup {
      Glyph("━", .horizontal, weight: .increased)
      Glyph("┃", .vertical, weight: .increased)
    }
  }

  static var straightsThin: Self {
    GlyphGroup {
      Glyph("─", .horizontal)
      Glyph("│", .vertical)
    }
  }

  // MARK: - All Joins
  static var joins: Self {
    joinsThick
      .merged(with: joinsThinInterior)
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
  static var joinsThinInterior: Box.GlyphGroup {
    GlyphGroup {
      Glyph("┯", .join(.top), x: .increased)
      Glyph("┷", .join(.bottom), x: .increased)
      Glyph("┠", .join(.leading), y: .increased)
      Glyph("┨", .join(.trailing), y: .increased)
      Glyph("╂", .join(.cross), y: .increased)
    }
  }

  // MARK: - All Corners
  static var corners: Box.GlyphGroup {
    cornersThin.merged(with: cornersThick)
  }

  // MARK: - Bold Corners
  static var cornersThick: Box.GlyphGroup {
    GlyphGroup {
      Glyph("┏", .corner(.topLeading), weight: .increased)
      Glyph("┓", .corner(.topTrailing), weight: .increased)
      Glyph("┗", .corner(.bottomLeading), weight: .increased)
      Glyph("┛", .corner(.bottomTrailing), weight: .increased)
    }
  }

  // MARK: - Thin Corners
  static var cornersThin: Box.GlyphGroup {
    GlyphGroup {
      Glyph("┌", .corner(.topLeading))
      Glyph("┐", .corner(.topTrailing))
      Glyph("└", .corner(.bottomLeading))
      Glyph("┘", .corner(.bottomTrailing))
    }
  }

}
