//
//  Glyph+Presets.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/11/2025.
//

//import EnumMacros
import BasePrimitives
import Foundation

extension Box.GlyphGroup {

  static var straights: Self {
    GlyphGroup {
      straightsThin
      straightsThick
    }
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
}
