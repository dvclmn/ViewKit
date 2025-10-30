//
//  GlyphSet.swift
//  BoxCore
//
//  Created by Dave Coleman on 12/9/2024.
//

extension Box {
  public typealias GlyphMap = [Box.GlyphType: Character]

  // https://www.hackingwithswift.com/example-code/language/what-are-indirect-enums
  public enum GlyphSet: Sendable {
    case base(GlyphMap)
    indirect case fallback(GlyphMap, GlyphSet)

    func character(for glyphType: GlyphType) -> Character {
      switch self {
        case .base(let glyphMap):
          return characterFromMap(glyphMap, for: glyphType) ?? "?"

        case .fallback(let glyphMap, let fallbackSet):
          return characterFromMap(
            glyphMap,
            for: glyphType
          ) ?? fallbackSet.character(for: glyphType)
      }
    }

    private func characterFromMap(
      _ glyphMap: GlyphMap,
      for glyphType: GlyphType
    ) -> Character? {

      /// Check for exact match
      if let char = glyphMap[glyphType] {
        return char
      }

      /// For join and corner, try equivalent interior variants first
      if let interior = fallBackInterior(glyphMap, for: glyphType) {
        return interior
      }

      /// Check for fallback within the same map
      if let fallbackType = glyphType.fallback {
        return glyphMap[fallbackType]
      }

      if let exterior = fallBackExterior(glyphMap, for: glyphType) {
        return exterior
      }

      return nil

    }  // END char from Map
  }
}

extension Box.GlyphSet {

  func fallBackInterior(
    _ glyphMap: Box.GlyphMap,
    for glyphType: Box.GlyphType
  ) -> Character? {
    switch glyphType {
      case .join(_, _, let type):
        let glyphType = Box.GlyphType.join(x: .interior, y: .interior, type: type)
        return glyphMap[glyphType]

      case .corner(_, let type):
        return glyphMap[.corner(location: .interior, type: type)]

      default: return nil
    }
  }

  func fallBackExterior(
    _ glyphMap: Box.GlyphMap,
    for glyphType: Box.GlyphType
  ) -> Character? {
    /// For join and corner, try falling back to exterior variants
    switch glyphType {
      case .join(_, _, let type):
        let type = Box.GlyphType.join(
          x: .exterior,
          y: .exterior,
          type: type
        )
        return glyphMap[type]

      case .corner(_, let type):
        let type = Box.GlyphType.corner(location: .exterior, type: type)
        return glyphMap[type]

      default:
        return nil
    }
  }
}
