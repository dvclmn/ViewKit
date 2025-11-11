//
//  GlyphType+Role.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/11/2025.
//

extension Box {
  public enum GlyphRole: Hashable, Codable, Sendable {
    case horizontal
    case vertical
    case corner(Box.CornerType)
    case join(Box.JoinType)
    case blank
  }
}

extension Box.GlyphRole {

  var name: String {
    switch self {
      case .horizontal: "H"
      case .vertical: "V"
      case .corner(let type): "Corner/\(type.rawValue)"
      case .join(let type): "Join/\(type.rawValue)"
      case .blank: "Blank"
    }
  }

  public init(fromPartRole partRole: Box.PartRole) {
    switch partRole {
      case .horizontal(_): self = .horizontal
      case .vertical(_): self = .vertical
      case .join(let type): self = .join(type)
      case .corner(let type): self = .corner(type)
      case .blank: self = .blank
    }
  }
}
