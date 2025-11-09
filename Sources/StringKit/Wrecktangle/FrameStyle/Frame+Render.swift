//
//  Frame+Render.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/11/2025.
//

#warning("Is this needed?")
extension Box {
  public struct FrameRenderer {
    let set: GlyphSet
    
    func render(_ frame: Box.FrameStyle) -> [[Character]] {
      frame.parts.values.flatMap { part in
        part.glyphs.map { row in
          row.map(set.resolve)
        }
      }
    }
  }
}
