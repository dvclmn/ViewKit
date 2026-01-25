//
//  WaveStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import ColourKit
import Foundation

/// What is being coloured though
public struct WaveStyle {
  /// Could these be thought of as like the equivalents in Gradient?
  /// How are these displayed? Running along the length of the wave?
  let colours: [RGBColour]
}

public struct LineStyle {
  let colour: RGBColour
  let colourSecondary: RGBColour?
  let lineWidth: CGFloat

  public init(
    colour: RGBColour,
    colourSecondary: RGBColour?,
    lineWidth: CGFloat
  ) {
    self.colour = colour
    self.colourSecondary = colourSecondary
    self.lineWidth = lineWidth
  }
}

public struct PointStyle {
  let colour: RGBColour
  let colourSecondary: RGBColour?
  let radius: CGFloat
  let shape: PointShape
}
