//
//  WaveStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import ColourKit
import Foundation

/// What is being coloured though
//public struct WaveStyle {
//  /// Could these be thought of as like the equivalents in Gradient?
//  /// How are these displayed? Running along the length of the wave?
//  let colours: [RGBColour]
//}

public struct LineStyle: Sendable, Codable, Equatable {
  let colour: RGBColour
  let colourSecondary: RGBColour?
  let lineWidth: CGFloat

  public init(
    colour: RGBColour = .gray,
    colourSecondary: RGBColour? = nil,
    lineWidth: CGFloat = 3.0
  ) {
    self.colour = colour
    self.colourSecondary = colourSecondary
    self.lineWidth = lineWidth
  }
}

public struct PointStyle: Sendable, Codable, Equatable {
  let colour: RGBColour
  let colourSecondary: RGBColour?
  let radius: CGFloat
  let shape: PointShape

  public init(
    colour: RGBColour = .brown,
    colourSecondary: RGBColour? = nil,
    radius: CGFloat = 9.0,
    shape: PointShape = .circle
  ) {
    self.colour = colour
    self.colourSecondary = colourSecondary
    self.radius = radius
    self.shape = shape
  }
}
