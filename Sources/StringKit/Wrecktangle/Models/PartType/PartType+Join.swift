//
//  PartType+Join.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/10/2025.
//

extension BoxPart.PartType {
  
  public enum Join: Hashable, Sendable {
    case leading
    case trailing
    case top
    case bottom
    case cross
  }

}

extension BoxPart.PartType.Join {
  func glyphStack() -> BoxPart.PartType.GlyphStack {
    switch self {
      case .leading:
        return [
          [
            Glyph.vertical(.exterior),
            Glyph.blank,
            /// I can use `joinType` directly here, as `PartType` and `GlyphType`
            /// share the same type for describing joins
            Glyph.join(x: .interior, y: .interior, type: joinType),
          ]
        ]
        
      case .trailing:
        output = [
          [
            Glyph.join(x: .interior, y: .interior, type: joinType),
            Glyph.blank,
            Glyph.vertical(.exterior),
          ]
        ]
        
      case .top:
        output = [
          [Glyph.horizontal(.exterior)],
          [Glyph.join(x: .interior, y: .interior, type: joinType)],
        ]
      case .bottom:
        output = [
          [Glyph.join(x: .interior, y: .interior, type: joinType)],
          [Glyph.horizontal(.exterior)],
        ]
      case .cross:
        output = [[Glyph.join(x: .interior, y: .interior, type: joinType)]]
    }

  }
}
