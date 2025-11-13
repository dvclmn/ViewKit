//
//  FrameStyle.swift
//  BoxCore
//
//  Created by Dave Coleman on 24/8/2024.
//

import SharedHelpers

extension Box {

  /// Represents a composition of Parts that describe a complete Frame
  public struct FrameStructure: Sendable, Codable, Equatable {

    var map: PartMap = [:]

    public init(@FrameBuilder _ content: () -> PartMap) {
      self.map = content()
    }
  }
}

extension Box.FrameStructure {

  /// The width of the Frame 'column', for the given location.
  /// This is the replacement for the older `var reservedWidth: Int {…}`
  func frameWidth(for location: Box.PartRole.VerticalLocation) -> Int? {
    return map[.vertical(location)]?.width
  }

  func part(for type: Box.PartRole) -> Part? { map[type] }

}

extension Box.FrameStructure: CustomStringConvertible {
  public var description: String { map.pretty }
}
