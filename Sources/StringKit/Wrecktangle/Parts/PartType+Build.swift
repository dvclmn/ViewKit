//
//  PartType+Build.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/11/2025.
//

import Foundation
import SharedHelpers

extension Box.PartRole {

  func part(
    using engine: Box.Engine,
    position: Box.PositionContext
  ) -> Box.PartStructure {
    
    print("quick check: \(self.pretty)")
    guard let part = engine.theme.frameStyle.frame.part(for: self) else {
      assertionFailure(
        "Missing \(self) for Frame Preset '\(engine.framePreset.name)', with Glyph design '\(engine.glyphDesign.name)'")
      return .blank
    }
    return part
  }
}

extension StringStack {
//  public init(from part: Box.PartResolved) {
//    let resolver = Box.Resolver(
//      glyphSet: part.glyphs.first?.first?.glyphSet ?? Box.GlyphSet.default
//    )
//    let characterGrid = resolver.characters(from: part)
//    self.init(characterGrid)
//  }
//  
  public init(from descriptors: [[Box.GlyphDescriptor]], using glyphSet: Box.GlyphSet) {
    let resolver = Box.Resolver(glyphSet: glyphSet)
    let characterGrid = resolver.characters(from: descriptors)
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
