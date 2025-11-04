//
//  GlyphType+Placement.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/11/2025.
//

public typealias Prominence = Box.GlyphProminence

extension Box {

  /// Describes the visual weight / thickness of this glyph.
  /// Usually used in conjunction with location/placement, to
  /// create the desired effect, such as a bolder exterior
  /// structure, and lighter interior.
  public enum GlyphProminence: Hashable, Sendable, Codable {
    case standard
    case increased
  }
}

extension Box.GlyphProminence {
  fileprivate var alt: Self {
    switch self {
      case .standard: .increased
      case .increased: .standard
    }
  }
}

extension Box.GlyphType {

  /// Returns a copy of this glyph type, with flipped Prominence
  var prominenceAlt: Box.GlyphType? {
    switch self {
      case .horizontal(let prominence):
        .horizontal(prominence.alt)

      case .vertical(let prominence):
        .vertical(prominence.alt)

      case .corner(let prominence, let type):
        .corner(prominence.alt, type: type)

      case .join(let x, let y, let type):
        .join(x: x.alt, y: y.alt, type: type)

      case .blank:
        nil
    }
  }
}
