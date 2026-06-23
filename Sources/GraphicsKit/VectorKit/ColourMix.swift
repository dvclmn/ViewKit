//
//  ColourMix.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/6/2026.
//

import ColourTools

public struct ColourMix: Sendable, Codable, Hashable {
  let primary: RGBColour
  let secondary: RGBColour?
  let strength: Double

  public init(
    primary: RGBColour,
    secondary: RGBColour?,
    strength: Double = 1.0
  ) {
    self.primary = primary
    self.secondary = secondary
    self.strength = strength
  }

}

extension ColourMix {
  
  public static func solid(colour: RGBColour) -> Self {
    .init(primary: colour, secondary: nil)
  }
  public var isSolidColour: Bool { secondary == nil }
}

