//
//  PartBuilder.swift
//  BoxCore
//
//  Created by Dave Coleman on 12/9/2024.
//

extension Box {
  typealias GlyphStack = [[GlyphType]]
}

extension BoxPart.PartType {

  public func preset(with frameStyle: Box.Theme.FrameStyle) -> [[Box.GlyphType]] {
    switch frameStyle {
      case .single: frameSingle()
      case .double: frameDouble()
    }  // END switch frame style
  }
}
