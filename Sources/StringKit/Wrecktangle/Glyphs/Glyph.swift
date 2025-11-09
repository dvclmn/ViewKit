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
  ///    Glyph("┌", .horizontal, .standard, .sharp): "─",)
  /// }
  /// ```
  ///
  /// I think this essentially provides a slightly nicer wrapper around `GlyphMap`
  public struct GlyphDef {
    let character: Character
    let descriptor: Glyph

    public init(
      _ character: Character,
      _ role: Box.GlyphDescriptor.Role,
      weight: Box.GlyphDescriptor.Prominence = .standard,
      style: Box.GlyphDescriptor.Design = .sharp
    ) {
      self.character = character
      self.descriptor = GlyphDescriptor(role, weight, style)
    }
  }
}
