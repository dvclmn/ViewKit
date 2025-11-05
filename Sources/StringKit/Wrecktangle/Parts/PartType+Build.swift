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
    using engine: Box.PartEngine,
    repeating count: Int? = nil,
  ) -> StringStack {

    let part = glyphStack(using: engine)
    let stringStack = part.toStringStack(with: engine.theme)

    guard let count, count > 1 else {
      return stringStack
    }

    return stringStack.repeated(along: .horizontal, count: count)
  }

  func glyphStack(using engine: Box.PartEngine) -> Part {
    switch engine.theme.frameStyle {

      case .single(let frameProm, let divProm):
        return singleFrameParts(frameProm: frameProm, divProm: divProm)

      case .double(let extProm, let intProm):
        return doubleFrameParts(extProm: extProm, intProm: intProm)

      case .notebook:
        return notebookParts(using: engine)
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
