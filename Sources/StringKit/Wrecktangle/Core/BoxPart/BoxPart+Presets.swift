//
//  PartBuilder.swift
//  BoxCore
//
//  Created by Dave Coleman on 12/9/2024.
//

extension Box {
  /// A 2D array of Glyphs. This represents multiple rows (lines)
  /// of text, *however*: these usually will not stretch the full
  /// text width of the overall Box drawing. These are stitched
  /// together with other multi-line stacks, to form a cohesive whole.
  public typealias GlyphStack = [[GlyphType]]
}

extension Box.PartType {

  public func preset(with frameStyle: Box.Theme.FrameStyle) -> Box.GlyphStack {
    switch frameStyle {
      case .single: frameStackSingle
      case .double: frameStackDouble
    }
  }
}
