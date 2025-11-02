//
//  PartType+Join.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension Box {

  /// Describes where the joining takes place
  public enum JoinType: Hashable, Sendable, Codable {
    case leading  // ┠
    case trailing  // ┨
    case top  // ┯
    case bottom  // ┷
    case cross  // ╂
  }
}

extension Box.JoinType {

  func glyphStack() -> Box.GlyphStack {
    switch self {
      case .leading:
        [
          [
            Box.GlyphType.vertical(.bold),
            Box.GlyphType.blank,
            Box.GlyphType.join(weightX: .thin, weightY: .thin, type: self),
          ]
        ]

      case .trailing:
        [
          [
            Box.GlyphType.join(weightX: .thin, weightY: .thin, type: self),
            Box.GlyphType.blank,
            Box.GlyphType.vertical(.bold),
          ]
        ]

      case .top:
        [
          [Box.GlyphType.horizontal(.bold)],
          [Box.GlyphType.join(weightX: .thin, weightY: .thin, type: self)],
        ]

      case .bottom:
        [
          [Box.GlyphType.join(weightX: .thin, weightY: .thin, type: self)],
          [Box.GlyphType.horizontal(.bold)],
        ]
      case .cross:
        [[Box.GlyphType.join(weightX: .thin, weightY: .thin, type: self)]]
    }

  }
}
