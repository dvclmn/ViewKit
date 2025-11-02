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
    /// Try exact match
    if let char = map[type] {
      return char
    }
    
    /// Try flipped placement
    if let flipped = type.alternateProminence,
       let char = map[flipped] {
      return char
    }
    
    /// No match
    return nil
  }
}
