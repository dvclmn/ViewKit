//
//  GlyphGroup.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/11/2025.
//

import SharedHelpers

typealias GlyphGroup = Box.GlyphGroup

extension Box {
  struct GlyphGroup {
    //  struct GlyphGroup: Mergable {

    var map: GlyphMap

    init(glyphs: GlyphMap) {
      self.map = glyphs
    }

    //    init(_ presets: Presets) {
    //      self = Self.fromPresets(presets)
    //    }

    init(@GlyphSetBuilder _ glyphs: () -> GlyphMap) {
      self.map = glyphs()
    }
  }
}

extension Box.GlyphGroup {

  //  private static let presetMap: [Presets: GlyphGroup] = [
  //    .straightsThin: .straightsThin,
  //    .straightsThick: .straightsThick,
  //    .joinsThin: .joinsThin,
  //    .joinsThick: .joinsThick,
  //    .joinsThickExtThinInt: .joinsThickExtThinInt,
  //    .cornersThinSharp: .cornersThinSharp,
  //    .cornersThickSharp: .cornersThickSharp,
  //  ]
  //
  //  static func fromPresets(_ presets: Presets) -> Self {
  //    let groups: [GlyphGroup] = presetMap.compactMap { (key, group) in
  //      presets.contains(key) ? group : nil
  //    }
  ////    return groups.reduce(Self(glyphs: [:])) { $0.merged(with: $1) }
  ////    return groups.merged(keeping: .custom({ current, new in
  ////      <#code#>
  ////    }))
  //
  //    return
  //
  ////    return groups.merged(
  ////      keeping: .custom { current, new in
  ////        current.merged(with: new)
  ////      }
  ////    )
  //  }
}
