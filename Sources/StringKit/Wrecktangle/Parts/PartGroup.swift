//
//  PartGroup.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/11/2025.
//

extension Box {
  struct PartGroup {
    var map: GlyphStack

    public init(parts: GlyphStack) {
      self.map = parts
    }

    /// Builder init
    init(@PartBuilder _ content: () -> GlyphStack) {
      self.map = content()
    }
  }
}
