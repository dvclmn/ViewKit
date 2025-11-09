//
//  Glyph+Descriptor.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/11/2025.
//

import Foundation

extension Box {

  public struct GlyphDescriptor: Hashable, Codable {
    var role: Role
    var weight: Prominence
    var style: Style

    enum Role: Hashable, Codable {
      case horizontal
      case vertical
      case corner(CornerType)
      case join(JoinType)
      case blank
    }

    enum Style: String, Hashable, Codable {
      case sharp
      case rounded
      case double
      case ascii
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
}
