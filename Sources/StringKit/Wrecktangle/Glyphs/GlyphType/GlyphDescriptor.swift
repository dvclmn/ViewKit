//
//  Glyph+Descriptor.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/11/2025.
//

import Foundation

extension Box {

  /// The building block used by ``Box/PartType``.
  /// Refers to a *single character* (glyph) only.
  /// Distinct from ``Box/PartType``, which handles
  /// a composite of glyphs to form a useful whole.
  ///
  /// This was previously the `GlyphType` enum, with
  /// horizontal, vertical, join, corner, blank and literal
  public struct GlyphDescriptor: Hashable, Codable, Sendable {
    var role: GlyphRole
    var weight: GlyphWeight
    var design: GlyphDesign

    public init(
      _ role: GlyphRole,
      weight: GlyphWeight = .standard,
      design: GlyphDesign = .sharp
    ) {
      self.role = role
      self.weight = weight
      self.design = design
    }

    public init(
      _ role: GlyphRole,
      x: GlyphWeight.WeightType = .standard,
      y: GlyphWeight.WeightType = .standard,
      design: GlyphDesign = .sharp
    ) {
      self.role = role
      self.weight = GlyphWeight(x: x, y: y)
      self.design = design
    }
  }
}

extension Box.GlyphDescriptor: CustomStringConvertible {
  public var description: String {
    "GlyphType[GlyphRole/\(role.name), Weight/\(weight), Design/\(design.rawValue)]"
  }
}
