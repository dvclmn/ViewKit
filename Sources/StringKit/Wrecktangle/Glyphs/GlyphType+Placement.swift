//
//  GlyphType+Placement.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/11/2025.
//

extension Box.GlyphType {

  /// Describes where this Glyph should be used, in the context
  /// of a Box structure. Typically based on interior vs exterior
  /// usage; bolder glyph weight for exterior, lighter for interior.
  public enum Placement: Hashable, Sendable, Codable {
    case interior
    case exterior
  }
}

extension Box.GlyphType.Placement {
  fileprivate var flipped: Self {
    switch self {
      case .interior: return .exterior
      case .exterior: return .interior
    }
  }
}

extension Box.GlyphType {

  /// Returns a copy of this glyph type, with its placement(s) flipped
  /// from interior <-> exterior where applicable.
  var flippedPlacement: Self? {
    switch self {
      case .horizontal(let placement):
        return .horizontal(placement.flipped)

      case .vertical(let placement):
        return .vertical(placement.flipped)

      case .corner(let location, let type):
        return .corner(location: location.flipped, type: type)

      case .join(let x, let y, let type):
        return .join(x: x.flipped, y: y.flipped, type: type)

      case .blank:
        return nil
    }
  }
}
