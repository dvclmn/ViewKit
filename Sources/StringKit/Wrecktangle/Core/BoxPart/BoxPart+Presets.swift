//
//  PartBuilder.swift
//  BoxCore
//
//  Created by Dave Coleman on 12/9/2024.
//

extension Box {
  /// A 2D array of Glyphs, representing multiple rows of text
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
