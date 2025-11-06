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

    init(
      @PartBuilder _ content: () -> GlyphStack
    ) {
      self.glyphs = content()
    }
  }
}

extension Box.Part {
  var width: Int { glyphs.width }

  func toStringStack(with theme: Box.Theme) -> StringStack {
    glyphs.toStringStack(with: theme)
  }
}

// MARK: - Part Span
extension Box {
  public enum PartSpan {
    case fill
    case fixed(Int)

    static var single: PartSpan { .fixed(1) }
  }
}
