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
    let parts: Set<Box.Part>
    //    var parts: PartMap = [:]

    public init(@FrameBuilder _ content: () -> FrameBuilderOutput) {
      //    public init(@FrameBuilder _ content: () -> PartMap) {
      self.parts = Set(content())
      //      self.parts = content()
    }

    public init(parts: Set<Box.Part>) {
      //    public init(parts: PartMap) {
      self.parts = parts
    }
  }
}

extension Box.FrameStyle {

  /// The width of the Frame 'column', for the given location.
  /// This is the replacement for the older `var reservedWidth: Int {…}`
  func frameWidth(for location: Box.PartType.VerticalLocation) -> Int? {
    return partMap[.vertical(location)]?.width
  }

  var partMap: Box.PartMap {
    Dictionary(
      uniqueKeysWithValues: parts.map { part in
        (part.type, part)
      }
    )
  }

  func part(for type: Box.PartType) -> Part? { partMap[type] }

  func merged(overrides: Set<Box.Part>) -> Box.FrameStyle {
    //  func merged(overrides: Box.PartMap) -> Box.FrameStyle {
    var newParts = parts
    //    for (key, value) in overrides {
    for part in overrides {
      newParts.update(with: part)
      //      newMap[key] = value
    }
    return Box.FrameStyle(parts: newParts)
  }

  // MARK: - Debugging
  func debugDump() {
    print("FrameStyle parts:")
    for (key, value) in partMap {
      print(
        """
        \(key) → \(value.glyphs.map {
          $0.map(\.description).joined()
        })
        """)
    }
  }
}

extension Box.FrameStyle: CustomStringConvertible {
  public var description: String {
    "FrameStyle[parts: \(partMap.prettyString)]"
  }
}
