//
//  GlyphRetrieval.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 31/10/2025.
//

extension Box {
//  public typealias GlyphMap = [Box.GlyphType: Character]
  public typealias GlyphMap = [GlyphDescriptor: Character]
}

protocol GlyphProvider {
  func character(
    for type: Box.GlyphType,
    with fallback: Character
  ) -> Character
}

extension Box.GlyphSet: GlyphProvider {
  func character(
    for type: Box.GlyphType,
    with fallbackCharacter: Character = "🐶"
  ) -> Character {
    
    guard !type.isLiteral else {
      let literalChar: Character? = switch type {
        case .literal(let character): character
        default: nil
      }
      return literalChar ?? fallbackCharacter
    }
    return switch self {
      case .base(let map):
        map[type]
          ?? map[optionalKey: type.prominenceAlt]
          ?? fallbackCharacter

      case .partial(let glyphMap, let fallback):
        glyphMap[type] ?? fallback.character(for: type)
    }
  }
}
