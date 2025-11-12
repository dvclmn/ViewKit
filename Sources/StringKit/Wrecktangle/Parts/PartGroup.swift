//
//  PartGroup.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/11/2025.
//

typealias PartGroup = Box.PartGroup

extension Box {
  struct PartGroup: Sendable, Codable, Equatable, Mergable {
    var map: PartMap = [:]
    //    var parts: [Box.PartStructure]
    //    var glyphs: GlyphStack

    public init(
      role: PartRole,
      glyphs: GlyphStack
    ) {
      let part = Box.PartStructure(role, glyphs: glyphs)
      let parts = [part]
      //      let merged = parts.merged(keeping: .last)
      let map = parts.toDictionary(key: \.role, value: \.self, keeping: .first)
      //      self.parts = [part]
      self.map = map
    }

    public init(parts: [Box.PartStructure]) {
      let map = parts.toDictionary(key: \.role, value: \.self, keeping: .first)
      //      self.parts = parts
      //      self.in
    }

    /// Builder init
    init(@FrameBuilder _ parts: () -> PartMap) {
      //    init(@PartBuilder _ parts: () -> GlyphStack) {

      self.map = parts()
    }
  }
}
