//
//  Ext+GraphicsContext.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/10/2025.
//

import SwiftUI


extension GraphicsContext {

  // MARK: - Patterns
  public func drawPattern(
    _ pattern: PatternStyle,
    config: PatternConfiguration = .default,
    in size: CGSize
  ) {
    switch pattern {
      case .checkerboard: drawCheckerboard(
          config: config,
          size: size
        )
      case .chevron: drawChevron(
          config: config,
          size: size
        )

      case .stitches: drawStitches(
          config: config,
          size: size
        )

      case .waves: drawWaves(
          config: config,
          size: size
        )

      case .stripes: drawStripes(
          config: config,
          size: size
        )

    }
  }

}
