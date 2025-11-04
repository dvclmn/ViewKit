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
  public enum GlyphSet: Sendable, Codable, Equatable {

    case base(GlyphMap)

    /// `indirect` because we need to specify the set
    /// to fall back on, for partial sets
    indirect case partial(GlyphMap, GlyphSet)
  }
}
