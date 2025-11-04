//
//  GlyphType+Placement.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/11/2025.
//

public typealias Prominence = Box.GlyphProminence

extension Box {

  /// Describes where this Glyph should be used, in the context
  /// of a Box structure. Typically based on interior vs exterior
  /// usage; bolder glyph weight for exterior, lighter for interior.
  public enum GlyphProminence: Hashable, Sendable, Codable {
    case standard
    case increased
  }
}

extension Box.GlyphProminence {
  fileprivate var alternate: Self {
    switch self {
      case .standard: .increased
      case .increased: .standard
    }
  }
}

extension Box.GlyphType {

  /// Returns a copy of this glyph type, with flipped Prominence
  var alternateProminence: Box.GlyphType? {
    switch self {
      case .horizontal(let prominence):
        .horizontal(prominence.alternate)

      case .vertical(let prominence):
        .vertical(prominence.alternate)

      case .corner(let prominence, let type):
        .corner(prominence.alternate, type: type)

      case .join(let x, let y, let type):
        .join(x: x.alternate, y: y.alternate, type: type)

      case .blank:
        nil
    }
  }
}
