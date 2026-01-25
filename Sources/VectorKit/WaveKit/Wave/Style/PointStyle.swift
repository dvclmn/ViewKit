//
//  PointStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import ColourKit
import Foundation

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

extension PointStyle {
  public static let example: Self = .init(
    colour: .purple,
    colourSecondary: .orange,
    radius: 3.0,
    shape: .circle
  )
}
