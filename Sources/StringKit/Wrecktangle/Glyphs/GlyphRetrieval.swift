//
//  GlyphRetrieval.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 31/10/2025.
//

extension Box {
  public typealias GlyphMap = [Box.GlyphType: Character]
}

/// You’ve already got a really clean fallback mechanism (partial + base).
/// If you ever want more fine-grained control, one improvement might be to
/// model fallback resolution via a simple protocol rather than a manual switch.

/// That is, you could move character(for:) into a protocol like:
protocol GlyphProvider {
  func character(
    for type: Box.GlyphType,
    with fallback: Character
  ) -> Character
}

/// Then make both `GlyphMap` and `GlyphSet` conform, so `GlyphSet`
/// can compose multiple sources more generically.
/// It’s almost the same logic — but it means `GlyphSet` could later be composed
/// dynamically from multiple sources, like a theme stack, not just nested `.partial`
extension Box.GlyphSet: GlyphProvider {
  func character(
    for type: Box.GlyphType,
    with fallbackCharacter: Character = " "
  ) -> Character {
    switch self {
      case .base(let map):
        map[type]
          ?? map[optionalKey: type.prominenceAlt]
          ?? fallbackCharacter

      case .partial(let glyphMap, let fallback):
        glyphMap[type] ?? fallback.character(for: type)
    }
  }
}
