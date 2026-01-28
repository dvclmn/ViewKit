//
//  Patterns.swift
//  Components
//
//  Created by Dave Coleman on 14/11/2024.
//

//#if canImport(AppKit)

import ColourKit
import SwiftUI

public struct PatternCanvas: View {

  let style: PatternStyle
  let config: PatternConfiguration

  public init(
    _ style: PatternStyle,
    config: PatternConfiguration = .init(),
  ) {
    self.style = style
    self.config = config
  }
  public init(
    preset: PatternPreset,
  ) {
    self.style = preset.style
    self.config = preset.config
  }

  public var body: some View {
    Canvas {
      context,
      size in
      context.drawPattern(style, in: size)
    }
  }
}

extension PatternCanvas {

  public func patternColours(
    _ foreground: HSVColour,
    _ background: HSVColour,
  ) -> Self {
    let currentStyle = self.style
    var newConfig = self.config
    newConfig.primaryColour = foreground
    newConfig.secondaryColour = background
    return PatternCanvas(currentStyle, config: newConfig)
  }

  public func patternSize(_ size: CGFloat) -> Self {
    let currentStyle = self.style
    var newConfig = self.config
    newConfig.size = size
    return PatternCanvas(currentStyle, config: newConfig)
  }

  public func patternOffset(x: CGFloat = 0, y: CGFloat = 0) -> Self {
    let currentStyle = self.style
    var newConfig = self.config
    newConfig.offset = CGSize(width: x, height: y)
    return PatternCanvas(currentStyle, config: newConfig)
  }

  public func patternGap(_ gap: CGFloat) -> Self {
    let currentStyle = self.style
    var newConfig = self.config
    newConfig.gap = gap
    return PatternCanvas(currentStyle, config: newConfig)
  }

  public func patternSizeAndGap(_ size: CGFloat, _ gap: CGFloat) -> Self {
    let currentStyle = self.style
    var newConfig = self.config
    newConfig.size = size
    newConfig.gap = gap
    return PatternCanvas(currentStyle, config: newConfig)
  }
}
