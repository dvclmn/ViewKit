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
        shape: .wave(strength: 6, sampleCount: 80),
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

  public static var wavy03: Self {
    .init(
      density: 20,
      minWidth: 100,
      maxWidth: 80,
      cycles: 5,
      shape: .diamond,
      radiusInner: 2.3,
      colourInner: RGBColour(0.25, 0.35, 0.2),
      variantionInner: 0.5,
      radiusOuter: 0.1,
      colourOuter: RGBColour(0.65, 0.35, 0.1),
      variantionOuter: 0.1,
      shaders: ShaderEffect.wavyPreset02
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

extension ShaderEffect {
  public static var wavyPreset: [ShaderEffect] {
    [
      .chromaticSubtle,

      .crtCurvature(strength: 0.0, zoom: 0.5),
      //      .crtCurvature(k1: 2.0, k2: 2.0),
      .crtLines(
        lineSpacing: 2.0,
        lineIntensity: 0.5,
        phosphorSize: 1.0,
        brightness: 0.4
      ),
      //      .crtCurvature(k1: 0.5, k2: 0.5),
      .radialBlur(
        origin: .zero,
        strength: 2.0,
        start: 0.7,
        end: 0.9,
        samples: 10
      ),
    ]
  }

  public static var wavyPreset02: [ShaderEffect] {
    [
      .chromaticPresetA,

      .crtCurvature(strength: 10.0, zoom: 1.5),

      .crtLines(
        lineSpacing: 4.0,
        lineIntensity: 0.4,
        phosphorSize: 1.0,
        brightness: 1.8
      ),

      .radialBlur(
        origin: .zero,
        strength: 2.0,
        start: 0.7,
        end: 0.9,
        samples: 10
      ),
    ]
  }
}
