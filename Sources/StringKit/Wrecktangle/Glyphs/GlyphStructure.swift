//
//  Glyph+Structure.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/11/2025.
//

/// For use within Frame builders. Describes structure only, not design
public typealias GlyphType = Box.GlyphStructure

/// 2D array of structure-describing Glyphs
public typealias GlyphStack = [[Box.GlyphStructure]]

/// For `GlyphSet` builders. Describes design of individual `Character`s
public typealias Glyph = Box.GlyphResolved

extension Box {

  /// Describes structure in terms of placement and weight (aka prominence).
  /// Intentionally omits any info relating to the *design* of Glyphs, so a Frame
  /// can declare Glyph Structure without yet being concerned with Glyph Design.
  public struct GlyphStructure: Sendable, Codable, Hashable {
    let role: GlyphRole
    let weight: Box.GlyphWeight

    public init(
      _ role: GlyphRole,
      weight: Box.GlyphWeight = .standard
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

extension Box.GlyphStructure {
  func merged(with other: Self) -> Self {
    print("Merging two GlyphStructures")
    guard role == other.role else {
      print("Roles don't match: \(role) != \(other.role)")
      return self
    }
    return Box.GlyphStructure(role, weight: weight.merged(with: other.weight))
  }
}

extension Box.GlyphStructure: CustomStringConvertible {
  public var description: String {
    "\(role) \(weight)"
  }
}
