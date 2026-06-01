//
//  PointStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import Foundation
import CoreTools
import ViewTools
import BaseTools
import ColourTools

public struct PointStyle: Sendable, Codable, Equatable, Hashable {
  public var shape: PointShape
  public var radius: Double
  public var colour: RGBColour
  public var colourSecondary: RGBColour?
  public var colourMixStrength: Double

  public init(
    shape: PointShape = .circle,
    radius: Double = 9.0,
    colour: RGBColour = .brown,
    colourSecondary: RGBColour? = .purple,
    colourMixStrength: Double = 3.5
  ) {
    self.shape = shape
    self.radius = radius
    self.colour = colour
    self.colourSecondary = colourSecondary
    self.colourMixStrength = colourMixStrength
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
