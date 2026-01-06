//
//  Ext+GraphicsContext.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/10/2025.
//

import SwiftUI

@available(macOS 14.0, *)
extension GraphicsContext {

  // MARK: - Patterns
  public func drawPattern(
    _ pattern: PatternStyle,
    config: PatternConfiguration = .default,
    in size: CGSize
  ) {
    switch pattern {
      case .checkerboard:
        return drawCheckerboard(
          config: config,
          size: size
        )
      case .chevron:
        return drawChevron(
          config: config,
          size: size
        )

      case .stitches:
        return drawStitches(
          config: config,
          size: size
        )

      case .waves:
        return drawWaves(
          config: config,
          size: size
        )

      case .stripes:
        return drawStripes(
          config: config,
          size: size
        )

    }
  }

}
