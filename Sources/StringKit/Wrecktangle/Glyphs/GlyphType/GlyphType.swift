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
  public struct GlyphType: Hashable, Codable, Sendable {
    var role: Role
    var weight: Prominence
    var design: Design

    public init(
      _ role: Role,
      weight: Prominence = .standard,
      design: Design = .sharp
    ) {
      self.role = role
      self.weight = weight
      self.design = design
    }

    public init(
      _ role: Role,
      x: ProminenceType = .standard,
      y: ProminenceType = .standard,
      design: Design = .sharp
    ) {
      self.role = role
      self.weight = Prominence(x: x, y: y)
      self.design = design
    }
  }
}

extension Box.GlyphType: CustomStringConvertible {
  public var description: String {
    "GlyphType[Role/\(role.name), Weight/\(weight), Design/\(design.rawValue)]"
  }
}
