//
//  Indented+Lines.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 20/3/2026.
//

import Foundation



enum IndentGlyphStyle {
  case standard
  case rounded

  var glyphs: IndentGlyphs {
    switch self {
      case .standard:
        IndentGlyphs(
          corner: "└",
          join: "├",
          horizontal: "─",
          vertical: "│"
        )
      case .rounded:
        IndentGlyphs(
          corner: "╰",
          join: "├",
          horizontal: "─",
          vertical: "│"
        )
    }
  }
}

struct IndentGlyphs {
  let corner: Character
  let join: Character
  let horizontal: Character
  let vertical: Character
}
