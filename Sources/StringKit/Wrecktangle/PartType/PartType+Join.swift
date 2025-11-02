//
//  PartType+Join.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension Box {

  /// Describes where the joining takes place
  public enum Join: Hashable, Sendable, Codable {
    case leading  // ┠
    case trailing  // ┨
    case top  // ┯
    case bottom  // ┷
    case cross  // ╂
  }
}

extension Box.PartType.Join {

  func glyphStack() -> Box.GlyphStack {
    switch self {
      case .leading:
        return [
          [
            Box.GlyphType.vertical(.exterior),
            Box.GlyphType.blank,
            /// I can use `joinType` directly here, as `PartType` and `GlyphType`
            /// share the same type for describing joins
            Box.GlyphType.join(x: .interior, y: .interior, type: self),
          ]
        ]

      case .trailing:
        return [
          [
            Box.GlyphType.join(x: .interior, y: .interior, type: self),
            Box.GlyphType.blank,
            Box.GlyphType.vertical(.exterior),
          ]
        ]

      case .top:
        return [
          [Box.GlyphType.horizontal(.exterior)],
          [Box.GlyphType.join(x: .interior, y: .interior, type: self)],
        ]
      case .bottom:
        return [
          [Box.GlyphType.join(x: .interior, y: .interior, type: self)],
          [Box.GlyphType.horizontal(.exterior)],
        ]
      case .cross:
        return [[Box.GlyphType.join(x: .interior, y: .interior, type: self)]]
    }

  }
}
