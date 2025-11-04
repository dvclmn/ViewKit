//
//  PartType+Build.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/11/2025.
//

import Foundation

extension Box.PartType {

  public func buildStack(using engine: Box.Engine) -> StringStack {

    guard self.flexibility.isRepeatable else {
      let stack = glyphStack(with: engine.theme.frameStyle)
      return StringStack(from: stack, with: engine.theme)
    }

    let reservedWidth = engine.widthForText

    let stack = glyphStack(with: engine.theme.frameStyle)
    let stringStack = StringStack(from: stack, with: engine.theme)
    let repeated = stringStack.repeated(along: .horizontal, count: reservedWidth)
    return repeated
  }

  func glyphStack(
    with frameStyle: Box.FrameStyle
  ) -> Box.GlyphStack {
    switch frameStyle {
      case .single(let frameProm, let divProm):
        return singleFrameParts(frameProm: frameProm, divProm: divProm)

      case .double(let extProm, let intProm):
        return doubleFrameParts(extProm: extProm, intProm: intProm)
        
      case .notebook:
        return GlyphGrid {
          Row {
            Glyph.horizontal(.standard)
          }
        }
    }
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
