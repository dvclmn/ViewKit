//
//  PartType+Build.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/11/2025.
//

import Foundation

extension Box.PartType {

  public func width(for frameStyle: Box.FrameStyle) -> Int {
    let stack = self.glyphStack(with: frameStyle)
    let width = stack.width
    return width
  }

  /// For parts requiring repetition, supply a value to `repeatCount`.
  /// Otherwise, this defaults to a single instance.
  ///
  /// We return a `StringStack`, not a `String`, to allow
  /// any additional repeating/joining required further down the pipeline.
  public func buildPart(
    with theme: Box.Theme,
    repeatCount: Int = 1,
    at rowPosition: Box.PositionContext? = nil
  ) -> StringStack {

    let part = glyphStack(with: theme.frameStyle)
    let stringStack = part.toStringStack(with: theme)

    guard repeatCount > 1 else {
      return stringStack
    }
    let repeated = stringStack.repeated(along: .horizontal, count: repeatCount)
    return repeated
  }

  func glyphStack(
    with frameStyle: Box.FrameStyle
  ) -> Part {
    switch frameStyle {

      case .single(let frameProm, let divProm):
        return singleFrameParts(frameProm: frameProm, divProm: divProm)

      case .double(let extProm, let intProm):
        return doubleFrameParts(extProm: extProm, intProm: intProm)

      case .notebook:
        return Part {
          Row {
            Glyph.horizontal(.standard)
          }
        }
    }
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
    let glyphSet = theme.glyphSet
    let charMatrix = glyphStack.map { row in
      row.map { glyphSet.character(for: $0) }
    }

    self.init(charMatrix)
  }

}
