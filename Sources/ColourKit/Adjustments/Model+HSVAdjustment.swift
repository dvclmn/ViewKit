//
//  Model+HSVAdjustment.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 29/6/2025.
//

import CurveKit
import SharedHelpers
import SwiftUI

/// Represents a *delta* adjustment in HSV space
/// Does not set hsb values to these, but adds to them
public struct HSVAdjustment: Sendable {

  /// Important: This `hue` is cyclic. I am no longer using
  /// `UnitIntervalCyclic` because it's fiddly, but
  /// this does still need (somehow) to be made cyclic
  public var hue: Double?
  public var saturation: Double?
  public var brightness: Double?

  //  public init(
  //    hue: Double? = nil,
  ////    hue: UnitIntervalCyclic? = nil,
  //    saturation: Double? = nil,
  //    brightness: Double? = nil
  //  ) {
  //    self.hue = hue
  //    self.saturation = saturation
  //    self.brightness = brightness
  //  }

  public init(
    hue: Double? = nil,
    saturation: Double? = nil,
    brightness: Double? = nil
  ) {
    self.hue = hue
    self.saturation = saturation
    self.brightness = brightness
  }

  public init(
    h: Double? = nil,
    s: Double? = nil,
    v: Double? = nil,
  ) {
    self.init(hue: h, saturation: s, brightness: v)
  }
}

extension Color {
  public var hsvAdjustment: HSVAdjustment {
    let nsColour = NSColor(self)
    let hue = nsColour.hueComponent
    let sat = nsColour.saturationComponent
    let val = nsColour.brightnessComponent
    return HSVAdjustment(h: hue, s: sat, v: val)
  }
  public func hsvAdjusted(by adjustment: HSVAdjustment, strength: Double = 0.5) -> Color {
    let adjusted: HSVAdjustment = hsvAdjustment.interpolated(towards: adjustment, strength: strength)
    return adjusted.toColour(withBase: self)
  }
}

extension HSVAdjustment {

  public func toColour(withBase base: Color) -> Color {
    guard let hue, let saturation, let brightness else { return base }
    let nsColour = NSColor(hue: hue, saturation: saturation, brightness: brightness, alpha: 1.0)
    return Color(nsColor: nsColour)
  }

  public static func adjustments(
    from modifiers: [any HSVModifier]
  ) -> [Self] {
    /// Extracts just the adjustments from the provided modifiers
    return modifiers.map(\.adjustment)
  }

  public static var zero: HSVAdjustment {
    HSVAdjustment(h: nil, s: nil, v: nil)
  }

  public func interpolated(
    towards other: HSVAdjustment,
    strength: Double
  ) -> HSVAdjustment {
    HSVAdjustment(
      hue: hue.interpolated(towards: other.hue, strength: strength),
      saturation: saturation.interpolated(towards: other.saturation, strength: strength),
      brightness: brightness.interpolated(towards: other.brightness, strength: strength)
    )
  }

  //  func scaleAll(by factor: Double) -> HSVAdjustment {
  //    HSVAdjustment(
  //      hue: hue.map { $0.value * factor },
  //      saturation: saturation.map { $0 * factor },
  //      brightness: brightness.map { $0 * factor }
  //    )
  //  }
  //
  //  func scale(
  //    _ keyPath: WritableKeyPath<HSVAdjustment, Double>,
  //    by factor: Double
  //  ) -> HSVAdjustment {
  //    var result = self
  //    result[keyPath: keyPath] *= factor
  //    return result
  //  }

  /// With `interpolated`, `HSVAdjustment` now knows how to
  /// go from one instance of itself, to another, linearly interpolating.
  ///
  /// The key here is that a `HSVAdjustment` describes
  /// the properties neccesary to actually *change* a given colour.
  /// These values/presets are described elsewhere, such as
  /// `ColourModification` and `ContrastPreset` etc.
  ///
  /// But here, we can go from one, to another, which is very useful.
  //  func interpolated(
  //    towards other: HSVAdjustment,
  //    strength: Double
  //  ) -> HSVAdjustment {
  //    HSVAdjustment(
  //      hue: self.hue.interpolated(
  //        towards: other.hue,
  //        strength: strength
  //      ),
  //      saturation: self.saturation.interpolated(
  //        towards: other.saturation,
  //        strength: strength
  //      ),
  //      brightness: self.brightness.interpolated(
  //        towards: other.brightness,
  //        strength: strength
  //      )
  //    )
  //  }

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

}

public func + (lhs: HSVAdjustment, rhs: HSVAdjustment) -> HSVAdjustment {
  HSVAdjustment(
    hue: lhs.hue.combined(with: rhs.hue) {
      $0.interpolated(towards: $1, strength: 1.0)
    },
    saturation: lhs.saturation.combined(with: rhs.saturation, using: +),

    brightness: lhs.brightness.combined(with: rhs.brightness, using: +)
  )
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
        let value = from.interpolated(towards: to, strength: strength)
        return value
    }
  }
}
