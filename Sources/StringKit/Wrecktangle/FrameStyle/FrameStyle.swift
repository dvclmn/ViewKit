//
//  FrameStyle.swift
//  BoxCore
//
//  Created by Dave Coleman on 24/8/2024.
//

import SharedHelpers

//public typealias Frame = Box.FrameStyle

extension Box {
  struct FrameStyle {
    let frame: Frame
    let glyphSet: GlyphSet
  }
}

extension Box {

  public typealias PartMap = [Box.PartType: Box.Part]

  public struct Frame: Sendable, Codable, Equatable {
    let partTypes: Set<Box.PartType>
    //    var parts: PartMap = [:]

    public init(@FrameBuilder _ content: () -> FrameBuilderOutput) {
      //    public init(@FrameBuilder _ content: () -> PartMap) {
      self.partTypes = Set(content())
      //      self.parts = content()
    }

    public init(parts: Set<Box.PartType>) {
      //    public init(parts: PartMap) {
      self.partTypes = parts
    }
  }
}

extension Box.Frame {

  /// The width of the Frame 'column', for the given location.
  /// This is the replacement for the older `var reservedWidth: Int {…}`
  func frameWidth(
    for location: Box.PartType.VerticalLocation
  ) -> Int? {
//    let part = self.partTypes.first(where: { })
    
//    return partMap[.vertical(location)]?.width
  }

//  var partMap: Box.PartMap {
//    Dictionary(
//      uniqueKeysWithValues: partTypes.map { part in
//        (part, part)
//      }
//    )
//  }

  func part(for type: Box.PartType) -> Part? {
    
//    partMap[type]
  }

  func merged(overrides: Set<Box.Part>) -> Box.Frame {
    //  func merged(overrides: Box.PartMap) -> Box.Frame {
    var newParts = parts
    //    for (key, value) in overrides {
    for part in overrides {
      newParts.update(with: part)
      //      newMap[key] = value
    }
    return Box.Frame(parts: newParts)
  }

  // MARK: - Debugging
  func debugDump() {
    print("Frame parts:")
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

extension Box.Frame: CustomStringConvertible {
  public var description: String {
    "Frame[parts: \(partMap.prettyString)]"
  }
}
