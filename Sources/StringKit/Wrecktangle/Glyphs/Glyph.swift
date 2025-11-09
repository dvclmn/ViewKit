//
//  Glyph.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/11/2025.
//

public typealias Glyph = Box.Glyph

extension Box {
  /// This should be what is visible *within* the `GlyphSet` builder
  /// ```
  /// GlyphSet {
  ///    Glyph("┌", .horizontal, .standard, .sharp): "─",)
  /// }
  /// ```
  ///
  /// I think this essentially provides a slightly nicer wrapper around `GlyphMap`
  public struct Glyph: Sendable {
    let character: Character
    let descriptor: GlyphType

    public init(
      _ character: Character,
      _ role: Box.GlyphDescriptor.Role,
      weight: Box.GlyphDescriptor.Prominence = .standard,
      design: Box.GlyphDescriptor.Design = .sharp
    ) {
      self.character = character
      self.descriptor = GlyphDescriptor(role, weight: weight, design: design)
    }

    public init(
      _ character: Character,
      _ role: Box.GlyphDescriptor.Role,
      x: Box.GlyphDescriptor.ProminenceType = .standard,
      y: Box.GlyphDescriptor.ProminenceType = .standard,
      //      weight: Box.GlyphDescriptor.Prominence = .standard,
      design: Box.GlyphDescriptor.Design = .sharp
    ) {
      self.character = character
      self.descriptor = GlyphDescriptor(role, x: x, y: y, design: <#T##Box.GlyphDescriptor.Design#>)
//      self.descriptor = GlyphDescriptor(role, weight: weight, design: design)
    }
  }

}
extension Box.Glyph {
  static let blank = Box.Glyph(.blank, .blank)
}
