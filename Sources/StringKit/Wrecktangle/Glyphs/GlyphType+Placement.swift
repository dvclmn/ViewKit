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
  public enum Prominence: Hashable, Sendable, Codable {
    case light
    case regular
    case strong
  }
}

extension Box.GlyphType.Prominence {
  fileprivate var alternate: Self {
    switch self {
      case .thin: .strong
      case .strong: .thin
      case .regular: .regular
    }
  }
}

extension Box.GlyphType {

  /// Returns a copy of this glyph type, with flipped Prominence
  var alternateProminence: Box.GlyphType? {
    switch self {
      case .horizontal(let weight):
        .horizontal(weight.alternate)

      case .vertical(let weight):
        .vertical(weight.alternate)

      case .corner(let weight, let type):
        .corner(weight.alternate, type: type)

      case .join(let x, let y, let type):
        .join(x: x.alternate, y: y.alternate, type: type)

      case .blank, .text:
        nil
    }
  }
}
