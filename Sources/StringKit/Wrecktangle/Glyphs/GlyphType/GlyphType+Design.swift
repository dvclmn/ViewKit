//
//  GlyphType+Design.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/11/2025.
//

extension Box {
  
  public enum GlyphDesign: String, Sendable, Hashable, Codable {
    case sharp
    case round
    
    /// Example: `╔═`
    /// Named `hollow` to disambiguate from Frame's `double`
    case hollow
  }
}

extension Box.GlyphDesign {
  public static var `default`: Self { .sharp }
  public var name: String { rawValue.capitalized }
}

