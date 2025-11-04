//
//  PartType+Build.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/11/2025.
//

import Foundation

extension Box.PartType {

//  public func toString(with theme: Box.Theme) -> String {
//
//    let glyphs = glyphStack(with: theme.frameStyle)
//    let stringStack = StringStack(from: glyphs, with: theme)
//    return stringStack.string
//  }
  
  public func buildStack(
    toWidth width: Int,
    using theme: Box.Theme
  ) -> StringStack {
    
    guard self.flexibility.isRepeatable else {
      let stack = glyphStack(with: theme.frameStyle)
      return StringStack(from: stack, with: theme)
    }
    
    let stack = glyphStack(with: theme.frameStyle)
    let stringStack = StringStack(from: stack, with: theme)
    let repeated = stringStack.repeated(along: .horizontal, count: width - theme.padding.width * 2)
    return repeated
  }


  //  public func buildStack(
  //    toWidth width: Int,
  //    using theme: Box.Theme
  //  ) -> StringStack {
  //
  //  }

  //  private func repeated() -> StringStack {
  //    let stack = glyphStack(with: theme.frameStyle)
  //    let stringStack = StringStack(from: stack, with: theme)
  //    let repeated = stringStack.repeated(along: .horizontal, count: width - theme.padding.width * 2)
  //    return repeated
  //  }

  func glyphStack(
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

  //  public init(
  //    _ theme: Box.Theme,
  //    @GlyphStackBuilder _ content: () -> Box.GlyphStack
  //  ) {
  //    self.init(from: content(), theme: theme)
  //  }

}

//extension Box.GlyphStack {
//
//}
