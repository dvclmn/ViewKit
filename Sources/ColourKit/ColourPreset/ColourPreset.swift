//
//  ColourPreset.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/10/2025.
//

import SwiftUI

public enum CodableColour: Codable, Equatable, Hashable, Sendable {
  case hex(String)
  case rgb(RGBColour)
  case hsv(HSVColour)
  case rgbRaw(r: Double, g: Double, b: Double)
  case system(SystemColour)
  case mix(
    SystemColour,
    SystemColour,
    Double = 0.5
  )
}

/// Need to think through the possible ways to express a Colour.
/// - Hex string
/// - RGB component float values
/// - Declarative, a bit like `ColourPreset` (which tbh is totally clunky)
///   This tries to combine some SwiftUI colour mixing, with secondary HSV adjustment
/// - System Colour / Primitives (no customisaton, just static members)
/// - Preset/Swatch – was previously what I used, in tandem with Xcode colour asset
//public protocol CodableColour: Codable, Equatable, Hashable {
//  var colour: Color { get }
//}

public struct ColourMix: Sendable, Codable, Equatable, Hashable {

  public let base: SystemColour
  public let mix: SystemColour
//  public let adjustment: HSVAdjustment?
  public let mixAmount: Double
//  public let opacity: Double

    public init(
      _ base: SystemColour,
      _ mix: SystemColour,
      mixAmount: Double = 0.5,
//      adjustment: HSVAdjustment? = nil,
//      opacity: Double = 1.0
    ) {
      self.base = base
      self.mix = mix
      self.mixAmount = mixAmount
//      self.adjustment = adjustment
//      self.opacity = opacity
    }

  public var colour: Color { base.withMix(mix, mixAmount) }
}
extension ColourMix {

//  public static let primary: Self = .init(.primary)
//  public static let secondary: Self = .init(.secondary)
  
  public static let greenNeon: Self = .init(
    .green,
    .yellow,
    mixAmount: 0.36,
//    adjustment: .init(s: -0.16, v: -0.16)
  )

  public static let pinkNeon: Self = .init(
    .pink,
    .blue,
    mixAmount: 0.46,
//    adjustment: .init(s: -0.4, v: -0.2)
  )
}
