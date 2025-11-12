//
//  PartGroup.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/11/2025.
//

typealias PartGroup = Box.PartGroup

extension Box {
  struct PartGroup {
    var parts: [Box.PartStructure]
//    var glyphs: GlyphStack

    public init(
      role: PartRole,
      glyphs: GlyphStack
    ) {
      let part = Box.PartStructure(role, glyphs: glyphs)
      self.parts = [part]
    }
    
    public init(parts: [Box.PartStructure]) {
      self.parts = parts
    }

    /// Builder init
    init(@FrameBuilder _ parts: () -> [Box.PartStructure]) {
//    init(@PartBuilder _ parts: () -> GlyphStack) {
      self.parts = parts()
    }
  }
}
