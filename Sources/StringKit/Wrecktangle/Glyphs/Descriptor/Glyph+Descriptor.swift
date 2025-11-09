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
    
    public init(
      _ role: Role,
      x: ProminenceType = .standard,
      y: ProminenceType = .standard,
      _ style: Style = .sharp
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

  public enum Style: String, Sendable, Hashable, Codable {
    case sharp
    case rounded
    
    /// Example: `╔═`
    /// Named `hollow` to disabiguate from Frame's `double`
    case hollow
  }
}
