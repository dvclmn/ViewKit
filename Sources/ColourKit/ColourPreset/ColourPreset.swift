//
//  ColourPreset.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/10/2025.
//

import SwiftUI

public struct ColourPreset: Sendable, Codable, Equatable, Hashable {
  public let base: SystemColour
  public let mix: SystemColour?
  public let mixAmount: Double
  public let opacity: Double
  
  public init(
    _ base: SystemColour,
    mix: SystemColour? = nil,
    mixAmount: Double = 0.5,
    opacity: Double = 1.0
  ) {
    self.base = base
    self.mix = mix
    self.mixAmount = mixAmount
    self.opacity = opacity
  }

  public var colour: Color {
    guard let mix else { return base.toColour }
    return base.withMix(mix, mixAmount).opacity(opacity)
  }
  
  public func hsvAdjusted(
    hue: Double,
    saturation: Double,
    brightness: Double,
    strength: Double = 1.0
  ) -> Color {
    let adjustment = HSVAdjustment(h: hue, s: saturation, v: brightness)
    return self.colour.hsvAdjusted(by: adjustment, strength: strength)
  }
}
extension ColourPreset {
  
  public static let greenNeon: ColourPreset = ColourPreset(.green, mix: .yellow, mixAmount: 0.1)
}
