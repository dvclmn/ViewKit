//
//  Group+Corners.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/11/2025.
//

extension Box.GlyphGroup {

  // MARK: - All Corners
  static var corners: Box.GlyphGroup {
    cornersThinSharp.merged(with: cornersThickSharp)
  }

  // MARK: - Bold Corners
  static var cornersThickSharp: Box.GlyphGroup {
    GlyphGroup {
      Glyph("┏", .corner(.topLeading), weight: .increased)
      Glyph("┓", .corner(.topTrailing), weight: .increased)
      Glyph("┗", .corner(.bottomLeading), weight: .increased)
      Glyph("┛", .corner(.bottomTrailing), weight: .increased)
    }
  }

  // MARK: - Thin Corners
  static var cornersThinSharp: Box.GlyphGroup {
    GlyphGroup {
      Glyph("┌", .corner(.topLeading))
      Glyph("┐", .corner(.topTrailing))
      Glyph("└", .corner(.bottomLeading))
      Glyph("┘", .corner(.bottomTrailing))
    }
  }
}
