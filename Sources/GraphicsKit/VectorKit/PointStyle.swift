//
//  PointStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import Foundation
import CoreTools
import ColourTools

public struct PointStyle: Sendable, Codable, Equatable, Hashable {
  public var shape: PointShape
  public var radius: Double
  public var colourMix: ColourMix
//  public var colour: RGBColour
//  public var colourSecondary: RGBColour?
//  public var colourMixStrength: Double

  public init(
    shape: PointShape = .circle,
    radius: Double = 9.0,
    colourMix: ColourMix = .init(
      primary: .brown,
      secondary: .purple,
      strength: 3.5
    )
  ) {
    self.shape = shape
    self.radius = radius
    self.colourMix = colourMix
  }

  public init(
    shape: PointShape = .circle,
    radius: Double = 9.0,
    colour: RGBColour = .brown,
    colourSecondary: RGBColour? = .purple,
    colourMixStrength: Double = 3.5
  ) {
    self.shape = shape
    self.radius = radius
    self.colourMix = .init(primary: colour, secondary: colourSecondary, strength: colourMixStrength)
//    self.colour = colour
//    self.colourSecondary = colourSecondary
//    self.colourMixStrength = colourMixStrength
  }
}

extension PointStyle {
  public static var example: Self {
    .init(
      shape: .circle,
      radius: 3.0,
      colour: .purple,
      colourSecondary: .orange,
    )
  }
}
