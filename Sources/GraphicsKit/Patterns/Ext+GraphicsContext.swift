//
//  Ext+GraphicsContext.swift
//  ViewKit
//
//  Created by Dave Coleman on 8/10/2025.
//

import SwiftUI

extension GraphicsContext {
  public func drawPattern(
    _ pattern: PatternStyle,
    config: PatternConfiguration = .default,
    in size: CGSize
  ) {
    switch pattern {
      case .checkerboard: drawCheckerboard(config, in: size)
      case .chevron: drawChevron(config, in: size)
      case .stitches: drawStitches(config, in: size)
      case .waves: drawWaves(config, in: size)
      case .stripes: drawStripes(config, in: size)
    }
  }
}
