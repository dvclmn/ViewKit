//
//  PartType+Build.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/11/2025.
//

import Foundation
import SharedHelpers

extension Box.PartType {

  /// We return a `StringStack`, not a `String`, to allow
  /// any additional repeating/joining required further down the pipeline.
  public func buildPart(
    using engine: Box.Engine,
    pos position: Box.PositionContext,
    span: Box.PartSpan = .single,
  ) -> StringStack {

    let part = part(using: engine, position: position)
    let stringStack = part.toStringStack(with: engine.theme)

    switch span {
      case .fill:
        return StringStack(repeating: stringStack, count: engine.width(for: .repeatedPart), along: .horizontal)

      case .fixed(let count):
        return if count == 1 {
          stringStack
        } else {
          StringStack(repeating: stringStack, count: count, along: .horizontal)
        }
    }
  }

  func part(
    using engine: Box.Engine,
    position: Box.PositionContext
  ) -> Box.Part {
    let frameStyle = engine.theme.frameStyle
    let fallback = Part(.blank) { Row { GlyphType.blank } }
    return frameStyle.part(for: self) ?? fallback
  }
}

extension StringStack {
  public init(
    from glyphStack: Box.GlyphStack,
    with theme: Box.Theme,
  ) {
    /// Convert from `GlyphType` → `Character`
    let characterGrid = glyphStack.map { row in
      return row.map {
        return theme.glyphSet.resolve($0)
      }
    }
    self.init(characterGrid)
  }

}
