//
//  Glyph+Descriptor.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/11/2025.
//

import Foundation

/// Hoping to rename so that `GlyphDef` (if it ends up working)
/// will become `Glyph`, and `GlyphDescriptor` will
/// become something else.
public typealias Glyph = Box.GlyphDescriptor

extension Box {

  /// The building block used by ``Box/PartType``.
  /// Refers to a *single character* (glyph) only.
  /// Distinct from ``Box/PartType``, which handles
  /// a composite of glyphs to form a useful whole.
  ///
  /// This was previously the `GlyphType` enum, with
  /// horizontal, vertical, join, corner, blank and literal
  public struct GlyphDescriptor: Hashable, Codable, Sendable {
    var role: Role
    var weight: Prominence
    var style: Design

    public init(
      _ role: Role,
      _ weight: Prominence = .standard,
      _ style: Design = .sharp
    ) {
      self.role = role
      self.weight = weight
      self.style = style
    }
    
    public init(
      _ role: Role,
      x: ProminenceType = .standard,
      y: ProminenceType = .standard,
      _ style: Design = .sharp
    ) {
      self.role = role
      self.weight = Prominence(x: x, y: y)
      self.style = style
    }

  }
}

extension Box.GlyphDescriptor {

  public enum Role: Hashable, Codable, Sendable {
    case horizontal
    case vertical
    case corner(Box.CornerType)
    case join(Box.JoinType)
    case blank
  }

  public enum Design: String, Sendable, Hashable, Codable {
    case sharp
    case rounded
    
    /// Example: `╔═`
    /// Named `hollow` to disabiguate from Frame's `double`
    case hollow
  }
}
