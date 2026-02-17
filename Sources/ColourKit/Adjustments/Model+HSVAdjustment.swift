//
//  Model+HSVAdjustment.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 29/6/2025.
//

import BasePrimitives
import SwiftUI

/// Represents a *delta* adjustment in HSV space
/// Does not set hsv values to these, but adds to them
public struct HSVAdjustment: Sendable, Codable, Equatable, Hashable {

  /// Important: This `hue` is cyclic. I am no longer using
  /// `UnitIntervalCyclic` because it's fiddly, but
  /// this does still need (somehow) to be made cyclic
  public var hue: Double?
  public var saturation: Double?
  public var brightness: Double?
  public let strength: Double

  public init(
    hue: Double? = nil,
    saturation: Double? = nil,
    brightness: Double? = nil,
    strength: Double = 1.0
  ) {
    self.hue = hue
    self.saturation = saturation
    self.brightness = brightness
    self.strength = strength
  }

  public init(
    h: Double? = nil,
    s: Double? = nil,
    v: Double? = nil,
  ) {
    self.init(hue: h, saturation: s, brightness: v)
  }
}

extension HSVAdjustment {

  public var toColour: Color? {
    guard let hue, let saturation, let brightness else { return nil }
    let nsColour = NSColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    return Color(nsColor: nsColour)
  }

  @available(
    *, deprecated, renamed: "toColour",
    message: "Prefer property version of this, rather than the method `toColour()`"
  )
  //  public func toColour() -> Color? {
  //    toColour
  //  }

  public static func adjustments(
    from modifiers: [any HSVModifier]
  ) -> [Self] {
    /// Extracts just the adjustments from the provided modifiers
    return modifiers.map(\.adjustment)
  }

  public static var zero: HSVAdjustment {
    HSVAdjustment(h: nil, s: nil, v: nil)
  }

  public func interpolated(towards other: HSVAdjustment) -> HSVAdjustment {
    HSVAdjustment(
      hue: hue.interpolated(towards: other.hue, strength: strength),
      saturation: saturation.interpolated(towards: other.saturation, strength: strength),
      brightness: brightness.interpolated(towards: other.brightness, strength: strength)
    )
  }

  static func applyingModifiers(
    for luminanceColour: any LuminanceReadable,
    strength: ModificationStrengthPreset,
    purpose: ColourPurpose = .legibility,
    chroma: ColourChroma = .standard
  ) -> Self {

    /// We don't handle `strength` just yet; first we gather
    /// the modifiers together for processing.
    let lumThreshold: LuminanceThreshold = .init(from: luminanceColour)

    let contributors: [any HSVModifier] = [
      lumThreshold,
      purpose,
      chroma,
    ]
    let adjustments = adjustments(from: contributors)

    let combined = adjustments.combined(with: strength.adjustmentStrength)

    return combined
  }

  public func adding(other: Self) -> Self {
    HSVAdjustment(
      hue: hue.combined(with: other.hue) {
        $0.interpolated(towards: $1, amount: 1.0)
      },
      saturation: saturation.combined(with: other.saturation, using: +),

      brightness: brightness.combined(with: other.brightness, using: +)
    )
  }
}

public func + (lhs: HSVAdjustment, rhs: HSVAdjustment) -> HSVAdjustment {
  lhs.adding(other: rhs)
}

extension Optional where Wrapped == Double {

  /// Cyclic interpolation for hue values (shortest path around color wheel)
  public func interpolated(
    towards other: Double?,
    strength: Double
  ) -> Double? {
    switch (self, other) {

      case (nil, nil): return nil

      /// Keep current hue when target is nil
      case (let hue?, nil): return hue

      /// Jump to target when current is nil
      case (nil, let target?): return target

      case (let from?, let to?):
        let value = from.interpolated(towards: to, amount: strength)
        return value
    }
  }
}
