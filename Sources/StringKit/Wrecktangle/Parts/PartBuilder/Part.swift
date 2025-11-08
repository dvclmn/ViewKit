//
//  Part.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/11/2025.
//

import Foundation

public typealias Part = Box.Part
extension Box {

  public struct Part: Sendable, Codable, Equatable {
    let type: PartType
    let glyphs: GlyphStack

    //    init(@PartBuilder _ content: () -> GlyphStack) {
    //      self.glyphs = content()
    //    }

    init(_ type: Box.PartType, @PartBuilder _ content: () -> Box.GlyphStack) {
      self.glyphs = content()
      self.type = type
    }
  }
}

extension Box.Part {
  var width: Int { glyphs.width(for: .widestRow) }

  func toStringStack(with theme: Box.Theme) -> StringStack {
    StringStack(from: glyphs, with: theme)
  }
}

// MARK: - Part Span
extension Box {
  public enum PartSpan {
    case fill
    case fixed(Int)

    public static var single: PartSpan { .fixed(1) }
  }
}

extension Part: CustomStringConvertible {
  public var description: String {
    "Part[Glyphs: \(glyphs), W: \(width), StringStack: \(toStringStack(with: .default))]"
  }
}
