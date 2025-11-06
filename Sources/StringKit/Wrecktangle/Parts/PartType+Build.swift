//
//  PartType+Build.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/11/2025.
//

import Foundation

extension Box.PartType {
  /// For parts requiring repetition, supply a value to `repeatCount`.
  /// Otherwise, this defaults to a single instance.
  ///
  /// We return a `StringStack`, not a `String`, to allow
  /// any additional repeating/joining required further down the pipeline.
  public func buildPart(
    
    using engine: Box.Engine,
    position: Box.PositionContext,
    repeating count: Int? = nil,
  ) -> StringStack {

    let part = glyphStack(using: engine, position: position)
    let stringStack = part.toStringStack(with: engine.theme)

    guard let count, count > 1 else {
      return stringStack
    }

    return stringStack.repeated(along: .horizontal, count: count)
  }

  private func rowNumberToStack(_ index: Int) -> StringStack {
    let indexString = index.toString
    let characters: [Character] = indexString.map { char in
      return Character(extendedGraphemeClusterLiteral: char)
    }

    return StringStack([characters])
  }

  func glyphStack(
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

extension Array where Element == [Box.GlyphType] {
  func toStringStack(with theme: Box.Theme) -> StringStack {
    return StringStack(from: self, with: theme)
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
