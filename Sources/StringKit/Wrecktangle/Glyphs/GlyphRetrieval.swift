//
//  GlyphRetrieval.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 31/10/2025.
//

extension Box {
  public typealias GlyphMap = [Box.GlyphType: Character]

  struct GlyphLookup {
    let map: GlyphMap
    let type: GlyphType
  }
}

extension Box.GlyphLookup {

  var character: Character? {

    /// Check for exact match
    if let char = map[type] {
      return char
    }

    /// For join and corner, try equivalent interior variants first
    if let interior = fallBackInterior {
      return interior
    }

    /// Check for fallback within the same map
    if let fallbackType = type.fallback {
      return map[fallbackType]
    }

    if let exterior = fallBackExterior {
      return exterior
    }

    return nil

  }  // END char from Map

  var fallBackInterior: Character? {
    switch type {
      case .join(_, _, let joinType):
        let glyphType = Box.GlyphType.join(x: .interior, y: .interior, type: joinType)
        return map[glyphType]

      case .corner(_, let cornerType):
        return map[.corner(location: .interior, type: cornerType)]

      default: return nil
    }
  }

  var fallBackExterior: Character? {
    switch type {
      case .join(_, _, let joinType):
        let type = Box.GlyphType.join(
          x: .exterior,
          y: .exterior,
          type: joinType
        )
        return map[type]

      case .corner(_, let cornerType):
        let type = Box.GlyphType.corner(location: .exterior, type: cornerType)
        return map[type]

      default:
        return nil
    }
  }
}
