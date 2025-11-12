//
//  Glyph.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/11/2025.
//

extension Box {
  /// This should be what is visible *within* the `GlyphSet` builder
  /// ```
  /// GlyphSet {
  ///    Glyph("┌", .horizontal, .standard, .sharp)
  /// }
  /// ```
  /// I think this essentially provides a slightly nicer wrapper around `GlyphMap`
  public struct GlyphResolved: Sendable {
    let character: Character
    let descriptor: GlyphDescriptor

    public init(
      _ character: Character,
      _ role: Box.GlyphRole,
      weight: Box.GlyphWeight = .standard,
    ) {
      self.character = character
      self.descriptor = .fromRole(role, weight: weight)
    }

    public init(
      _ character: Character,
      _ role: Box.GlyphRole,
      x: Box.GlyphWeight.WeightType = .standard,
      y: Box.GlyphWeight.WeightType = .standard,
    ) {
      self.init(
        character,
        role,
        weight: GlyphWeight(x: x, y: y),
      )
    }
  }

}
extension Box.GlyphResolved {
  static let blank = Box.GlyphResolved(.blank, .blank)

}
