//
//  Themes.swift
//  Helpers
//
//  Created by Dave Coleman on 23/8/2024.
//

import SwiftUI

extension Box {

  public struct Theme: Sendable {
    public var glyphSet: GlyphSet
    public var frameStyle: FrameStyle
    public var padding: Int

    public init(
      glyphSet: GlyphSet = .rounded,
      frameStyle: FrameStyle = .single,
      padding: Int = 1
    ) {
      self.glyphSet = glyphSet
      self.frameStyle = frameStyle
      self.padding = padding
    }
  }
}
