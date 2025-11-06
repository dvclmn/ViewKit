//
//  PartType+Build.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/11/2025.
//

import Foundation

extension Box.PartType {

  /// We return a `StringStack`, not a `String`, to allow
  /// any additional repeating/joining required further down the pipeline.
  public func buildPart(

    using engine: Box.Engine,
    position: Box.PositionContext,
    span: Box.PartSpan = .single,
  ) -> StringStack {

    let part = part(using: engine, position: position)
    let stringStack = part.toStringStack(with: engine.theme)

    switch span {
      case .fill:
        return stringStack.repeated(
          along: .horizontal,
          count: engine.width(for: .repeatedPart)
        )

      case .fixed(let count):
        return if count == 1 {
          stringStack
        } else {
          stringStack.repeated(along: .horizontal, count: count)
        }
    }
  }

  func part(
    using engine: Box.Engine,
    position: Box.PositionContext
  ) -> Part {
    switch engine.theme.frameStyle {
      case .single: singleFrameParts()
      case .double: doubleFrameParts()
      case .notebook: notebookParts(position: position)
    }  // END switch
  }
}

extension StringStack {
  public init(
    from glyphStack: Box.GlyphStack,
    with theme: Box.Theme,
  ) {
    let width = glyphStack.first?.count ?? 0
    precondition(
      glyphStack.allSatisfy { $0.count == width },
      "Non-rectangular glyph grid")

    /// Convert from `GlyphType` → `Character`
    let characterGrid = glyphStack.map { row in
      row.map { theme.glyphSet.character(for: $0) }
    }

    self.init(characterGrid)
  }

}
