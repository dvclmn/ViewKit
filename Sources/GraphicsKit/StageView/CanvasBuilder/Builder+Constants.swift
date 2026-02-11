//
//  Builder+Constants.swift
//  BaseDemos
//
//  Created by Dave Coleman on 2/2/2026.
//

import SwiftUI

extension CheckerBoardBuilder {

  package var width: CGFloat { size.width }
  package var height: CGFloat { size.height }

  public var offset: CGSize { config.offset }
  package var offsetX: CGFloat { offset.width }
  package var offsetY: CGFloat { offset.height }

  package var cellSize: CGFloat {
    config.size.clamped(to: config.sizeRange)
  }

  package var perspectiveStrength: CGFloat? {
    config.distortion.strengthValue?.clamped(to: config.distortion.strengthRange)
  }

  package var vanishingPoint: UnitPoint { config.vanishingPoint }

  package var absVanishingPoint: CGPoint {
    vanishingPoint.toCGPoint(in: size).adjustBoth {
      ($0 + width * 0.5, $1 + height * 0.48)  // Optical adjustment
    }
  }

  package var colours: (primary: Color, secondary: Color) {
    (config.colour.toColour, config.colourSecondary.toColour)
  }

  package var expansionPaddingCells: CGFloat? {
    // this can literally just be your existing expansionFactor,
    // but now it stays continuous, not truncated to Int
    //    expansionFactor

    /// Or, If you want to keep “factor” semantics vs “cells” semantics distinct, you can do:
    // e.g. 1 cell base padding, plus extra based on strength
    guard let perspectiveStrength else { return nil }
    return 1 + abs(perspectiveStrength) * 2
  }

}
