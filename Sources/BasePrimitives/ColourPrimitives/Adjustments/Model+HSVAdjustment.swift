//
//  Model+HSVAdjustment.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 29/6/2025.
//


//import CoreTools
import SwiftUI

/// Represents a *delta* adjustment in HSV space
/// Does not set hsv values to these, but adds to them
public struct HSVAdjustment: Sendable, Codable, Equatable, Hashable {

  /// Hue is cyclic. Unit interval `[0,1)`
  public var hue: Double?

  /// saturation and brightness are deltas. Expected range `−1…1`
  public var saturation: Double?
  public var brightness: Double?

  /// Scalar multiplier applied when combining/applying adjustments;
  /// not used as interpolation time parameter
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
  public init(fromAdjustable adjustable: some HSVAdjustable) {
    let hsv = adjustable.toHSV
    self.init(h: hsv.hue, s: hsv.saturation, v: hsv.brightness)
  }

  /// Removed `to​Colour` because a delta cannot be turned into a concrete Color without a base color.
  //  public var toColour: Color? {
  //    guard let hue, let saturation, let brightness else { return nil }
  //    let nsColour = NSColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
  //    return Color(nsColor: nsColour)
  //  }

  //  @available(
  //    *, deprecated, renamed: "toColour",
  //    message: "Prefer property version of this, rather than the method `toColour()`"
  //  )
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

  //  public func interpolated(towards other: HSVAdjustment) -> HSVAdjustment {
  //    HSVAdjustment(
  //      hue: hue.interpolatedHue(towards: other.hue, strength: strength),
  //      saturation: saturation.interpolated(towards: other.saturation, strength: strength),
  //      brightness: brightness.interpolated(towards: other.brightness, strength: strength)
  //    )
  //  }

  public func interpolated(
    towards other: HSVAdjustment,
    amount: Double
  ) -> HSVAdjustment {
    HSVAdjustment(
      hue: hue.interpolatedHue(towards: other.hue, amount: amount),
      saturation: saturation.interpolated(towards: other.saturation, amount: amount),
      brightness: brightness.interpolated(towards: other.brightness, amount: amount),
      strength: strength.interpolated(towards: other.strength, amount: amount)
    )
  }

  public func scaled(by factor: Double) -> HSVAdjustment {
    HSVAdjustment(
      hue: hue.map { $0 * factor },  // see clamping below
      saturation: saturation.map { $0 * factor },
      brightness: brightness.map { $0 * factor },
      strength: strength * factor
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

  public func adding(
    other: Self,
    shouldScaleStrength: Bool = false
  ) -> Self {
    HSVAdjustment(
      hue: hue.combined(with: other.hue) { $0.interpolatedHue(towards: $1, amount: 1.0) },
      saturation: saturation.combined(with: other.saturation, using: +),
      brightness: brightness.combined(with: other.brightness, using: +),
      strength: shouldScaleStrength ? strength + other.strength : self.strength
    )
    //    HSVAdjustment(
    //      hue: hue.combined(with: other.hue) {
    //        $0.interpolated(towards: $1, amount: 1.0)
    //      },
    //      saturation: saturation.combined(with: other.saturation, using: +),
    //
    //      brightness: brightness.combined(with: other.brightness, using: +)
    //    )
  }
}

public func + (lhs: HSVAdjustment, rhs: HSVAdjustment) -> HSVAdjustment {
  lhs.adding(other: rhs)
}

//extension Double {
//  func interpolatedHue(towards to: Double, amount t: Double) -> Double {
//    var delta = to - self
//    if delta > 0.5 { delta -= 1.0 }
//    if delta < -0.5 { delta += 1.0 }
//    var result = self + delta * t
//    if result < 0 { result += 1.0 }
//    if result >= 1 { result -= 1.0 }
//    return result
//  }
//}

//extension Optional where Wrapped == Double {
//  func interpolatedHue(towards other: Double?, strength: Double) -> Double? {
//    switch (self, other) {
//      case (nil, nil): return nil
//      case (let a?, nil): return a
//      case (nil, let b?): return b
//      case (let a?, let b?): return a.interpolatedHue(to: b, amount: strength)
//    }
//  }
//}
