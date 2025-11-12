//
//  PartGroup.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/11/2025.
//

typealias PartGroup = Box.PartGroup

extension Box {
  struct PartGroup: PartConvertible {
    var parts: [PartStructure]
    //    var glyphs: GlyphStack

    public init(parts: [PartStructure]) {
//      let part = PartStructure(role, glyphs: glyphs)
      self.parts = parts
    }

    public init(
      role: PartRole,
      glyphs: GlyphStack
    ) {
      let part = PartStructure(role, glyphs: glyphs)
      self.parts = [part]
    }

    /// Builder init
    init(@PartBuilder _ glyphs: () -> GlyphStack) {

      //      self.glyphs = glyphs()
    }
  }
}
extension Box.PartGroup {
  func toGlyphStack() -> GlyphStack { glyphs }
}
