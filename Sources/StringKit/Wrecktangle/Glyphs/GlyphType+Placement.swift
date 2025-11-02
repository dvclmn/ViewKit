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
  public enum Weight: Hashable, Sendable, Codable {
    case thin
    case bold
  }
}

extension Box.GlyphType.Weight {
  fileprivate var alternate: Self {
    switch self {
      case .thin: return .bold
      case .bold: return .thin
    }
  }
}

extension Box.GlyphType {

  /// Returns a copy of this glyph type, with its placement(s) flipped
  /// from interior <-> exterior where applicable.
  var alternateWeight: Box.GlyphType? {
    switch self {
      case .horizontal(let weight):
        .horizontal(weight.alternate)

      case .vertical(let weight):
        .vertical(weight.alternate)

      case .corner(let weight, let type):
        .corner(weight.alternate, type: type)

      case .join(let x, let y, let type):
        .join(weightX: x.alternate, weightY: y.alternate, type: type)

      case .blank, .text:
        nil
    }
  }
}
