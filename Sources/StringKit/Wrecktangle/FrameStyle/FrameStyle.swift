//
//  FrameStyle.swift
//  BoxCore
//
//  Created by Dave Coleman on 24/8/2024.
//

import SharedHelpers

public typealias Frame = Box.FrameStructure

extension Box {

  public typealias PartMap = [Box.PartRole: Box.PartStructure]

  public struct FrameStructure: Sendable, Codable, Equatable, Mergable {
    typealias Map = PartMap
//    var map: Map { parts }
    var map: PartMap = [:]

    public init(@FrameBuilder _ content: () -> PartMap) {
      self.map = content()
    }

    public init(partMap: PartMap) {
      self.map = partMap
    }
  }
}
//
//extension Box.FrameStructure: Box.Mergable {
//  
//}

extension Box.FrameStructure {

  /// The width of the Frame 'column', for the given location.
  /// This is the replacement for the older `var reservedWidth: Int {…}`
  func frameWidth(for location: Box.PartRole.VerticalLocation) -> Int? {
    return map[.vertical(location)]?.width
  }

  func part(for type: Box.PartRole) -> Part? {
    map[type]
  }

//  func merged(overrides: Box.PartMap) -> Self {
//    var newParts = parts
//    for (key, value) in overrides {
//      newParts[key] = value
//    }
//    return Self(partMap: newParts)
//  }

  // MARK: - Debugging
  func debugDump() {
    print("Frame parts:")
    //      for part in parts {
    for (key, value) in map {
      print(
        """
        \(key) → \(value.glyphs.map {
            $0.map(\.description).joined()
          })
        """)
    }
  }
}

extension Box.FrameStructure: CustomStringConvertible {
  public var description: String {
    "Frame[parts: \(map)]"
    //    "Frame[parts: \(parts.prettyString)]"
  }
}

