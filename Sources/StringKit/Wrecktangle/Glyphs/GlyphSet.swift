//
//  GlyphSet.swift
//  BoxCore
//
//  Created by Dave Coleman on 12/9/2024.
//

extension Box {

  /// A `GlyphSet` can either be a `base` set, or a `partial`set.
  ///
  /// A `base` set represents the 'most exhaustive' list of Glyphs, for describing
  /// an ASCII box drawing.
  ///
  /// A `partial` set can then build upon this foundation, specifying
  /// which `base` set to fall back on, for un-specified glyphs
  public enum GlyphSet: Sendable {

    public static let globalFallback: Character = "?"

    case base(GlyphMap)

    /// `indirect` because we need to specify the set
    /// to fall back on, for partial sets
    indirect case partial(GlyphMap, GlyphSet)
  }
}

extension Box.GlyphSet {

  /// Returns a Character for the given 'purpose' (Glyph Type),
  /// based on how it is defined for this Set.
  func character(for glyphType: Box.GlyphType) -> Character {

    switch self {
      /// This *should* return a result, as a Base set ought to be exhaustive
      case .base(let glyphMap):
        let lookup = Box.GlyphLookup(map: glyphMap, type: glyphType)
        return lookup.character ?? Self.globalFallback
      //        return characterFromMap(glyphMap, for: glyphType) ?? Self.globalFallback

      case .partial(let glyphMap, let fallbackSet):
        let lookup = Box.GlyphLookup(map: glyphMap, type: glyphType)
        let fallbackCharacter = fallbackSet.character(for: glyphType)
        return lookup.character ?? fallbackCharacter
    //        return characterFromMap(glyphMap, for: glyphType) ?? fallbackCharacter
    }
  }

}
