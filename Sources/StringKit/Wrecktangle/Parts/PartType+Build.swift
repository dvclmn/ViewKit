//
//  PartType+Build.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/11/2025.
//

import Foundation

extension Box.PartType {

  public func buildStack(
    toWidth width: Int,
    using theme: Box.Theme
  ) -> StringStack {

    guard self.flexibility.isRepeatable else {
      let stack = glyphStack(with: theme.frameStyle)
      return StringStack(from: stack, theme: theme)

    }
    let stack = glyphStack(with: theme.frameStyle)
    let stringStack = StringStack(from: stack, theme: theme)
    let repeated = stringStack.repeated(along: .horizontal, count: width - theme.padding.width * 2)
    return repeated
  }

  private func glyphStack(
    with frameStyle: Box.FrameStyle
  ) -> Box.GlyphStack {
    switch frameStyle {
      case .single(let frameProm, let divProm):
        let single = singleFrameParts(frameProm: frameProm, divProm: divProm)
        //        print("GlyphStack for PartType \(self), with Single FrameStyle: \(single)")
        return single

      case .double(let extProm, let intProm):
        let doubleResult = doubleFrameParts(extProm: extProm, intProm: intProm)
        //        print("GlyphStack for PartType \(self), with Double FrameStyle: \(doubleResult)")
        return doubleResult
    }
  }
}

extension StringStack {
  public init(
    from glyphStack: Box.GlyphStack,
    theme: Box.Theme
  ) {
    let grid = glyphStack.map { row in
      row.map { glyphType in
        theme.glyphSet.character(for: glyphType)
      }
    }
    print("Let's check the produced grid (`[[Character]]`), from the GlyphStack-based init for StringStack: \(grid)")
    self.init(grid)
  }

  public init(@GlyphStackBuilder _ content: () -> [[Box.GlyphType]]) {
    let glyphMatrix = content()
    let width = glyphMatrix.first?.count ?? 0
    precondition(glyphMatrix.allSatisfy { $0.count == width }, "Non-rectangular glyph grid")

    /// Convert from `GlyphType` → `Character`
    let glyphSet = Box.GlyphSet.sharp  // or passed-in variant
    let charMatrix = glyphMatrix.map { row in
      row.map { glyphSet.character(for: $0) }
    }

    self.init(charMatrix)
  }

}
