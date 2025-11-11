//
//  FrameStyle.swift
//  BoxCore
//
//  Created by Dave Coleman on 24/8/2024.
//

import SharedHelpers

public typealias Frame = Box.FrameStructure

extension Box {
  struct FrameStyle {
    let frame: FrameStructure
    let glyphSet: GlyphSet
  }
}

extension Box {

  public typealias PartMap = [Box.PartRole: Box.PartStructure]

  public struct FrameStructure: Sendable, Codable, Equatable {
    let parts: Set<Box.PartStructure>
//    let parts: Set<Box.PartRole>
    //    var parts: PartMap = [:]

    public init(@FrameBuilder _ content: () -> [Box.PartStructure]) {
      //    public init(@FrameBuilder _ content: () -> PartMap) {
      self.parts = Set(content())
      //      self.parts = content()
    }

    public init(parts: Set<Box.PartStructure>) {
      //    public init(parts: PartMap) {
      self.parts = parts
    }
  }
}

extension Box.FrameStructure {

  /// The width of the Frame 'column', for the given location.
  /// This is the replacement for the older `var reservedWidth: Int {…}`
//  func frameWidth(
//    for location: Box.PartRole.VerticalLocation
//  ) -> Int? {
    //    let part = self.partTypes.first(where: { })

    //    return partMap[.vertical(location)]?.width
//  }

  //  var partMap: Box.PartMap {
  //    Dictionary(
  //      uniqueKeysWithValues: partTypes.map { part in
  //        (part, part)
  //      }
  //    )
  //  }

//  func part(for type: Box.PartRole) -> Part? {
//parts
    //    partMap[type]
//  }

//  func merged(overrides: Set<Box.PartResolved>) -> Box.Frame {
//    //  func merged(overrides: Box.PartMap) -> Box.Frame {
//    var newParts = parts
//    //    for (key, value) in overrides {
//    for part in overrides {
//      newParts.update(with: part)
//      //      newMap[key] = value
//    }
//    return Box.Frame(parts: newParts)
//  }

  // MARK: - Debugging
//  func debugDump() {
//    print("Frame parts:")
//    for part in parts {
////    for (key, value) in parts {
//      print(
//        """
//        \(key) → \(value.glyphs.map {
//          $0.map(\.description).joined()
//        })
//        """)
//    }
//  }
}

extension Box.FrameStructure: CustomStringConvertible {
  public var description: String {
    "Frame[parts: \(parts)]"
//    "Frame[parts: \(parts.prettyString)]"
  }
}
