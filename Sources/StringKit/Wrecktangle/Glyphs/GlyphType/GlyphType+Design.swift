//
//  GlyphType+Design.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/11/2025.
//

extension Box.GlyphType {
  
  public enum Design: String, Sendable, Hashable, Codable {
    case sharp
    case round
    
    /// Example: `╔═`
    /// Named `hollow` to disabiguate from Frame's `double`
    case hollow
  }
}
