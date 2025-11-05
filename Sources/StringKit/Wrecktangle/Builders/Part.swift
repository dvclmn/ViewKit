//
//  Part.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/11/2025.
//

import Foundation

public typealias Part = Box.Part
extension Box {
  public struct Part {
    
    let glyphs: GlyphStack
    var width: Int { glyphs.width }

    init(
      @GlyphStackBuilder _ content: () -> [[Box.GlyphType]]
    ) {
      self.glyphs = content()
    }
  }
}

extension Box.Part {
  func toString(with theme: Box.Theme) -> String {
    glyphs.toStringStack(with: theme).string
  }
}
