//
//  Parts+StringStack.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 13/11/2025.
//

import CoreTools

extension StringStack {
  
//    public init(from part: Box.PartResolved) {
//      let resolver = Box.Resolver(
//        glyphSet: part.glyphs.first?.first?.glyphSet ?? Box.GlyphSet.default
//      )
//      let characterGrid = resolver.characters(from: part)
//      self.init(characterGrid)
//    }
  
  public init(
    from part: Box.PartResolved,
//    from descriptors: [[Box.GlyphDescriptor]],
    using glyphSet: Box.GlyphSet
  ) {
    
    let resolver = Box.Resolver(glyphSet: glyphSet)
    let characterGrid = resolver.characters(from: part)
    self.init(characterGrid)
  }
}

//extension StringStack {
//  public init(
//    from descriptors: [[Box.GlyphDescriptor]],
//    with theme: Box.Theme,
//  ) {
//    /// Convert from `GlyphType` → `Character`
//    let characterGrid = descriptors.map { row in
//      return row.map {
//
////        return theme.glyphSet.resolve($0)
//      }
//    }
//    self.init(characterGrid)
//  }
//
//}
