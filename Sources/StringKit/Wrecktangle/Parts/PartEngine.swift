//
//  PartEngine.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/11/2025.
//

import Foundation

extension Box {
  struct PartEngine {
    let theme: Box.Theme
    let repeatCount: Int
//    let boxEngine: Box.Engine
    let position: Box.PositionContext
  }
}

extension Box.PartEngine {
  /// True if this is in the top half of the box.
  var isTopHalf: Bool { position.progress < 0.5 }
  
  /// True if near edges (useful for fading or tapered patterns).
  var isNearEdge: Bool {
    let p = position.progress
    return p < 0.1 || p > 0.9
  }
  
  /// Returns an index for pattern sequences combining both axes.
  func phase(horizontal index: Int) -> Int {
    (position.rowIndex + index) % repeatCount
  }
  
  /// Convenience to alternate glyphs vertically.
  func alternatingGlyph(_ a: Box.GlyphType, _ b: Box.GlyphType) -> Box.GlyphType {
    position.isEven ? a : b
  }
}
