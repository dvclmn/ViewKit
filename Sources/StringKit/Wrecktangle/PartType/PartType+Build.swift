//
//  PartType+Build.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/11/2025.
//

import Foundation

//extension Box.PartType {
//  /// This will construct this `PartType`, including any join,
//  /// corner and text elements. We pass in the FrameStyle
//
//}
//
//

extension Box.PartType {

  //  func render(
  //    theme: Box.Theme
  //    //    toWidth target: Int? = nil
  //  ) -> String {
  //    let stack = self.buildStack(using: <#T##Box.Theme#>)
  //    guard let target,
  //          flexibility == .repeatable(axis: .horizontal)
  //    else { return stringStack.string }
  //
  //    return stringStack.repeatHorizontally(toWidth: target).string
  //  }

  /// Build this specific PartType. We need the Theme to
  /// know which specific Glyphs to ask for, and what
  /// FrameStyle to build for.
  func buildStack(using theme: Box.Theme) -> StringStack {
    let glyphStack: Box.GlyphStack =
      switch theme.frameStyle {
        case .single(frame: let frameProm, dividers: let divProm):
          return single(
            frameProm: frameProm,
            dividerProm: divProm
          )
        case .double(exterior: let extProm, interior: let intProm):
          return double(exterior: extProm, interior: intProm)
      }
    return StringStack(from: glyphStack, theme: theme)
    //  func build(using theme: Box.Theme) -> Box.GlyphStack {
    //  func buildFrame(using theme: Box.Theme) -> Box.Part {
    //    let glyphStack = theme.frameStyle.glyphStack(for: theme.frameStyle)
    //    let frameStack = theme.frameStyle.glyphStack(for: self)
    //    let stringStack = frameStack.map { row in
    //      row.map { theme.glyphSet.character(for: $0) }
    //    }
    //    return Box.Part(type: self, stringStack: StringStack(charGrid))
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
    self.init(grid)
  }
}
