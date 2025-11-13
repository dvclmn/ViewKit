//
//  GlyphKey.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/11/2025.
//

extension Box {
  // MARK: - GlyphKey
  /// Used for safe, predictable dictionary lookups
  public struct GlyphKey: Hashable, Sendable, Codable {
    let role: GlyphRole
    let weight: GlyphWeight
  }
}
