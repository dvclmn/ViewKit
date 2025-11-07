//
//  FrameStyle.swift
//  BoxCore
//
//  Created by Dave Coleman on 24/8/2024.
//

import SharedHelpers

public typealias Frame = Box.FrameStyle
extension Box {
  public struct FrameStyle: Sendable, Codable, Equatable {
    var parts: [PartType: Part] = [:]

    public init(parts: [PartType: Part]) {
      self.parts = parts
    }

    public init(@FrameStyleBuilder _ content: () -> PartMap) {
      self.parts = content()
    }
  }
}

extension Box.FrameStyle {

  /// The width of the Frame 'column', for the given location.
  /// This is the replacement for the older `var reservedWidth: Int {…}`
  func frameWidth(for location: Box.PartType.VerticalLocation) -> Int? {
    return parts[.vertical(location)]?.width
  }

  func part(for type: Box.PartType) -> Part? {
    parts[type]
  }

  func merged(
    overrides: Box.PartMap,
    reservedWidth: Int
  ) -> Box.FrameStyle {
    var newParts = parts
    for (key, value) in overrides {
      newParts[key] = value
    }
    return Box.FrameStyle(parts: newParts)
  }
}

//extension Box {
//
//  public enum FrameStyle: Sendable, Codable, Equatable {
//    case single
//    case double
//    case notebook
//  }
//}

//extension Box.FrameStyle {
//
//  var reservedWidth: Int {
//    switch self {
//      case .single: 1
//      case .double: 3
//      case .notebook: 3
//    }
//  }
//}
