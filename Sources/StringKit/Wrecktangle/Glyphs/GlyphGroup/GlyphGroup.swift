//
//  GlyphGroup.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/11/2025.
//

typealias GlyphGroup = Box.GlyphGroup

extension Box {
  struct GlyphGroup: Mergable {

    var map: GlyphMap

    init(glyphs: GlyphMap) {
      self.map = glyphs
    }

    init(presets: Presets) {
      
//      self.map = glyphs
    }

    init(@GlyphSetBuilder _ glyphs: () -> GlyphMap) {
//    init(@GlyphGroupBuilder _ glyphs: () -> GlyphMap) {
      self.map = glyphs()
    }
  }
}

extension Box.GlyphGroup {

  private static let presetMap: [Presets: GlyphGroup] = [
    .straightsThin: .straightsThin,
    .straightsThick: .straightsThick,
    .joinsThin: .joinsThin,
    .joinsThick: .joinsThick,
    .joinsThickExtThinInt: .joinsThickExtThinInt,
    .cornersThinSharp: .cornersThinSharp,
    .cornersThickSharp: .cornersThickSharp,
  ]

  static func fromPresets(_ presets: Presets) -> Self {
    let groups = presetMap.compactMap { (key, group) in
      presets.contains(key) ? group : nil
    }

    return groups.reduce(Self(glyphs: [:])) { $0.merged(with: $1) }
  }

  //  static func fromPresets(_ presets: Presets) -> Self {
  //    var groups: [Self] = []
  //
  //    if presets.contains(.straightsThin) {
  //      groups.append(.straightsThin)
  //    }
  //    if presets.contains(.straightsThick) {
  //      groups.append(.straightsThick)
  //    }
  //    if presets.contains(.joinsThin) {
  //      groups.append(.joinsThin)
  //    }
  //    if presets.contains(.joinsThick) {
  //      groups.append(.joinsThick)
  //    }
  //    if presets.contains(.joinsThickExtThinInt) {
  //      groups.append(.joinsThickExtThinInt)
  //    }
  //    if presets.contains(.cornersThinSharp) {
  //      groups.append(.cornersThinSharp)
  //    }
  //    if presets.contains(.cornersThickSharp) {
  //      groups.append(.cornersThickSharp)
  //    }
  //
  //    // Merge them all together
  //    return groups.reduce(Self(glyphs: [:])) { $0.merged(with: $1) }
  //  }
}
