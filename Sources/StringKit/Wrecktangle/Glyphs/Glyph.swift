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
  ///    Glyph("┌", .horizontal, .standard, .sharp)
  /// }
  /// ```
  ///
  /// I think this essentially provides a slightly nicer wrapper around `GlyphMap`
  public struct Glyph: Sendable {
    let character: Character
    let descriptor: GlyphType

    public init(
      _ character: Character,
      _ role: Box.GlyphRole,
      weight: Box.GlyphType.Prominence = .standard,
//      design: Box.GlyphType.Design = .sharp
//      design explicitDesign: Box.GlyphType.Design? = nil
      design: Box.GlyphType.Design? = nil
    ) {
      self.character = character
//      let inferredDesign = explicitDesign ?? GlyphDesignContext.currentDesign ?? .sharp
//      self.descriptor = GlyphType(role, weight: weight, design: inferredDesign)
      self.descriptor = .fromRole(role, weight: weight, design: design)
    }

    public init(
      _ character: Character,
      _ role: Box.GlyphRole,
      x: Box.GlyphType.ProminenceType = .standard,
      y: Box.GlyphType.ProminenceType = .standard,
//      design: Box.GlyphType.Design = .sharp
//      design explicitDesign: Box.GlyphType.Design? = nil
      design: Box.GlyphType.Design? = nil
    ) {
      self.init(
        character,
        role,
        weight: GlyphType.Prominence(x: x, y: y),
        design: design
      )
    }
  }

}
extension Box.Glyph {
  static let blank = Box.Glyph(.blank, .blank)
}
