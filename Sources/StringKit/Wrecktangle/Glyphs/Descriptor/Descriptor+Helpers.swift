//
//  Descriptor+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/11/2025.
//

extension Box.GlyphDescriptor {
  static func h(_ weight: Prominence = .standard, _ style: Style = .sharp) -> Self {
    .init(.horizontal, weight, style)
  }

  static func v(_ weight: Prominence = .standard, _ style: Style = .sharp) -> Self {
    .init(.vertical, weight, style)
  }

  static func corner(_ type: Box.CornerType, _ style: Style = .sharp) -> Self {
    .init(.corner(type), .standard, style)
  }
}
