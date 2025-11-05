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
      @PartBuilder _ content: () -> GlyphStack
    ) {
      self.glyphs = content()
    }
  }
}

extension Box.Part {
  
  func toStringStack(with theme: Box.Theme) -> StringStack {
    glyphs.toStringStack(with: theme)
  }
}
