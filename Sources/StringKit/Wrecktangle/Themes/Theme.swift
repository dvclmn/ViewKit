//
//  Themes.swift
//  Helpers
//
//  Created by Dave Coleman on 23/8/2024.
//

import SwiftUI
import SharedHelpers

extension Box {

  public struct Theme: Sendable {
    public var glyphSet: GlyphSet
    public var frameStyle: FrameStyle
    public var padding: GridDimensions

    public init(
      glyphSet: GlyphSet = .rounded,
      frameStyle: FrameStyle = .single(),
      padding: GridDimensions = 1
    ) {
      self.glyphSet = glyphSet
      self.frameStyle = frameStyle
      self.padding = padding
    }
  }
}

extension Box.Theme {
  public static let `default`: Box.Theme = .init()
}
