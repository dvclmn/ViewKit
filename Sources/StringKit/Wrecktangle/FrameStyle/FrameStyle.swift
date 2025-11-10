//
//  FrameStyle.swift
//  BoxCore
//
//  Created by Dave Coleman on 24/8/2024.
//

import SharedHelpers

public typealias Frame = Box.FrameStyle

extension Box {

  public typealias PartMap = [Box.PartType: Box.Part]

  public struct FrameStyle: Sendable, Codable, Equatable {
    var parts: PartMap = [:]

    public init(@FrameBuilder _ content: () -> PartMap) {
      self.parts = content()
    }

    public init(parts: PartMap) {
      self.parts = parts
    }
  }
}

extension Box.FrameStyle {

  /// The width of the Frame 'column', for the given location.
  /// This is the replacement for the older `var reservedWidth: Int {…}`
  func frameWidth(for location: Box.PartType.VerticalLocation) -> Int? {
    return parts[.vertical(location)]?.width
  }

  func part(for type: Box.PartType) -> Part? { parts[type] }

  func merged(overrides: Box.PartMap) -> Box.FrameStyle {
    var newParts = parts
    for (key, value) in overrides {
      newParts[key] = value
    }
    return Box.FrameStyle(parts: newParts)
  }
}
