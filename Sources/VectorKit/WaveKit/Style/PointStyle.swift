//
//  PointStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import ColourKit
import Foundation

public struct PointStyle: Sendable, Codable, Equatable, Hashable {
  public var shape: PointShape
  public var radius: Double
  public var colour: RGBColour
  public var colourSecondary: RGBColour?

  public init(
    shape: PointShape = .circle,
    radius: Double = 9.0,
    colour: RGBColour = .brown,
    colourSecondary: RGBColour? = .purple,
  ) {
    self.shape = shape
    self.radius = radius
    self.colour = colour
    self.colourSecondary = colourSecondary
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
