//
//  PartType+Build.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/11/2025.
//

import Foundation

extension Box.PartType {
  
  func buildStack(using theme: Box.Theme) -> StringStack {
    let stack = glyphStack(with: theme.frameStyle)
    return StringStack(from: stack, theme: theme)
  }

  func glyphStack(
    with frameStyle: Box.FrameStyle
  ) -> Box.GlyphStack {
    switch frameStyle {
      case .single(let frameProm, let divProm):
        let single = singleFrame(frameProm: frameProm, divProm: divProm)
        print("GlyphStack for PartType \(self), with Single FrameStyle: \(single)")
        return single
        
//        singleFrame(frameProm: frameProm, divProm: divProm)
      case .double(let extProm, let intProm):
        let doubleResult = double(extProm: extProm, intProm: intProm)
        print("GlyphStack for PartType \(self), with Double FrameStyle: \(doubleResult)")
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
}
