//
//  Glyph+Descriptor.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/11/2025.
//

import Foundation

public typealias Glyph = Box.GlyphDescriptor

extension Box {

  public struct GlyphDescriptor: Hashable, Codable, Sendable {
    var role: Role
    var weight: Prominence
    var style: Style

    public init(
      _ role: Role,
      _ weight: Prominence = .standard,
      _ style: Style = .sharp
    ) {
      self.role = role
      self.weight = weight
      self.style = style
    }

  }
}

extension Box.GlyphDescriptor {

  /// Describes the visual weight / thickness of this glyph.
  /// Usually used in conjunction with location/placement, to
  /// create the desired effect, such as a bolder exterior
  /// structure, and lighter interior.
  public enum Prominence: Hashable, Sendable, Codable {
    case standard
    case increased
  }

  public enum Role: Hashable, Codable, Sendable {
    case horizontal
    case vertical
    case corner(Box.CornerType)
    case join(Box.JoinType)
    case blank
  }

  public enum Style: String, Sendable, Hashable, Codable {
    case sharp
    case rounded
    
    /// Example: `╔═`
    /// Named `hollow` to disabiguate from Frame's `double`
    case hollow
  }
}
