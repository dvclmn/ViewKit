//
//  Themes.swift
//  Helpers
//
//  Created by Dave Coleman on 23/8/2024.
//

import SwiftUI
import SharedHelpers
import GridKit

extension Box {
  public struct Theme: Sendable, Codable, Equatable {
    public var glyphSet: GlyphSet
    public var frameStyle: FramePreset
    public var padding: GridDimensions

    public init(
      glyphSet: GlyphSet = .rounded,
      frameStyle: FramePreset = .double,
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
