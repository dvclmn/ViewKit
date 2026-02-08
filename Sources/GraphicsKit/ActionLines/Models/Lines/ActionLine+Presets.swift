//
//  ActionLine+Presets.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/2/2026.
//

import ColourKit
import Foundation

extension ActionLine.Configuration {
  public static var wavy: Self {
    .init(
      density: 50,
      radialCoverage: 1.0,
      lineStyle: ActionLine.LineStyle(
        shape: .wave(),
        minWidth: 24,
        maxWidth: 1
      ),
      outerShape: ActionLine.BoundaryStyle(
        radius: 0.7,
        colour: .aliceblue,
      ),
      innerShape: ActionLine.BoundaryStyle(
        radius: 0.5,
        colour: .oliveDark,
      ),
    )
  }

  public static var wavy02: Self {
    .init(
      density: 10,
      radialCoverage: 1.0,
      lineStyle: ActionLine.LineStyle(
        shape: .wave(),
        minWidth: 12,
        maxWidth: 1
      ),
      outerShape: ActionLine.BoundaryStyle(
        radius: 0.9,
        variation: 0.2,
        colour: RGBColour(0.15, 0.35, 0.6),
      ),
      innerShape: ActionLine.BoundaryStyle(
        radius: 0.05,
        position: CGPoint(10, 200),
        variation: 1.2,
        colour: RGBColour(0.65, 0.35, 0.3),
      ),
    )
  }

  public static var other: Self {
    .init(
      density: 50,
      radialCoverage: 1.0,
      lineStyle: ActionLine.LineStyle(
        shape: .diamond,
        minWidth: 40,
        maxWidth: 1
      ),
      outerShape: ActionLine.BoundaryStyle(
        radius: 1.0,
        colour: .brown,
      ),
      innerShape: ActionLine.BoundaryStyle(
        radius: 0.2
      ),
    )
  }
}
