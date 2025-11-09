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

extension Box.GlyphType.Role {
  public init(fromPartType partType: Box.PartType) {
    switch partType {
      case .horizontal(_): self = .horizontal
      case .vertical(_): self = .vertical
      case .join(let type): self = .join(type)
      case .corner(let type): self = .corner(type)
      case .blank: self = .blank
    }
  }
}
