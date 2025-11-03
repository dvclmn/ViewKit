//
//  PartType+Build.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/11/2025.
//

import Foundation

extension Box.PartType {

  public func glyphStack(
    with frameStyle: Box.FrameStyle
  ) -> Box.GlyphStack {
    switch frameStyle {
      case .single(let frameProm, let divProm):
        singleFrame(frameProm: frameProm, divProm: divProm)
      case .double(let extProm, let intProm):
        double(extProm: extProm, intProm: intProm)
    }
    //    switch frameStyle {
    //      case .single: singleFrame(frameProm: <#T##Box.GlyphProminence#>, dividerProm: <#T##Box.GlyphProminence#>)
    //      case .double: frameStackDouble
    //    }
  }

  /// Build this specific PartType. We need the Theme to
  /// know which specific Glyphs to ask for, and what
  /// FrameStyle to build for.
  //  func buildStack(using theme: Box.Theme) -> StringStack {
  //    let glyphStack =
  //      switch theme.frameStyle {
  //        case .single(
  //          frame: let frameProm,
  //          dividers: let divProm
  //        ):
  //          single(
  //            frameProm: frameProm,
  //            dividerProm: divProm
  //          )
  //        case .double(exterior: let extProm, interior: let intProm):
  //          double(exterior: extProm, interior: intProm)
  //      }
  //    return StringStack(from: glyphStack, theme: theme)
  //  }
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
