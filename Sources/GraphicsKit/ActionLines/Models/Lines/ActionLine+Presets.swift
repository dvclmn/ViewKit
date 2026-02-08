//
//  ActionLine+Presets.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/2/2026.
//

import ColourKit

extension ActionLine.Configuration {
  public static var wavy: Self {
    .init(
      density: 50,
      radialCoverage: 1.0,
      lineStyle: .init(
        shape: .wave,
        minWidth: 16,
        maxWidth: 1
      ),
      outerShape: .init(
        radius: 0.7,
        colour: .aliceblue,
//        colour: HSVColour(h: 0.75, s: 0.6, v: 0.5),
      ),
      innerShape: .init(
        radius: 0.5,
        colour: .oliveDark,
//        colour: HSVColour(h: 0.15, s: 0.5, v: 0.55),
      ),
    )
  }
  
  public static var wavy02: Self {
    .init(
      density: 90,
      radialCoverage: 1.0,
      lineStyle: .init(
        shape: .wave,
        minWidth: 26,
        maxWidth: 1
      ),
      outerShape: .init(
        radius: 0.7,
        colour: .aliceblue,
      ),
      innerShape: .init(
        radius: 0.1,
        colour: .oliveDark,
      ),
    )
  }

  public static var other: Self {
    .init(
      density: 50,
      radialCoverage: 1.0,
      lineStyle: .init(
        shape: .wave,
        minWidth: 40,
        maxWidth: 1
      ),
      outerShape: .init(
        radius: 1.0,
        colour: .brown,
//        colour: HSVColour(h: 0.25, s: 0.6, v: 0.5),
      ),
      innerShape: .init(
        radius: 0.2
      ),
    )
  }
}
