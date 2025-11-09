//
//  GlyphType+Role.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/11/2025.
//

extension Box.GlyphType {
  public enum Role: Hashable, Codable, Sendable {
    case horizontal
    case vertical
    case corner(Box.CornerType)
    case join(Box.JoinType)
    case blank
  }

}
