//
//  PartType+Build.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/11/2025.
//

import Foundation

extension Box.PartType {

  /// Build this specific PartType. We need the Theme to
  /// know which specific Glyphs to ask for, and what
  /// FrameStyle to build for.
  func buildStack(using theme: Box.Theme) -> StringStack {
    let glyphStack =
      switch theme.frameStyle {
        case .single(
          frame: let frameProm,
          dividers: let divProm
        ):
          single(
            frameProm: frameProm,
            dividerProm: divProm
          )
        case .double(exterior: let extProm, interior: let intProm):
          double(exterior: extProm, interior: intProm)
      }
    return StringStack(from: glyphStack, theme: theme)
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
