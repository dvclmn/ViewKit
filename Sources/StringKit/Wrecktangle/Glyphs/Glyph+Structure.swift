//
//  Glyph+Structure.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/11/2025.
//

/// For use within the body of Frame builders
/// Describes Structure only, not Design
public typealias GlyphType = Box.GlyphStructure
public typealias GlyphStack = [[Box.GlyphStructure]]

/// For GlyphSet builders
/// Describes actual individual Characters (Design/appearance)
public typealias Glyph = Box.GlyphResolved

extension Box {

  /// Describes enough about Structure as to be useful to
  /// Structure, but importabtly doesn't hold on to `GlyphDesign`
  /// at all, so is used for `FrameStyle`
  public struct GlyphStructure: Sendable, Codable, Hashable {
    let role: GlyphRole
    let weight: Box.GlyphWeight

    public init(
      _ role: GlyphRole,
      weight: Box.GlyphWeight
    ) {
      self.role = role
      self.weight = weight
    }
    public init(
      _ role: GlyphRole,
      x: GlyphWeight.WeightType = .standard,
      y: GlyphWeight.WeightType = .standard
    ) {
      let weight = GlyphWeight(x: x, y: y)
      self.init(role, weight: weight)
    }
  }  // END Glyph structure
}

extension Box.GlyphStructure: CustomStringConvertible {
  public var description: String {
    "\(role) \(weight)"
  }
}
