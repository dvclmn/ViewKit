//
//  Model+HSV.swift
//  BaseComponents
//
//  Created by Dave Coleman on 12/5/2025.
//

import SwiftUI

/// Notes:
/// In HSV, brightness (value) is the *maximum* of the RGB channels.
/// But luminance is a weighted sum of the linearised RGB values,
/// which means:
/// -  Two colours with the same HSV value might have
///   wildly different luminance.
/// -  Luminance depends on how the three channels contribute
///   based on human perception.

//
public struct HSVColour: Identifiable, Equatable, Sendable, ColourModel, Hashable {
  public let id: UUID
  public var hue: Double
  public var saturation: Double
  public var brightness: Double
  public var alpha: Double
  public var name: String?

  public init(
    hue: Double,
    saturation: Double,
    brightness: Double,
    alpha: Double = 1.0,
    name: String? = nil
  ) {
    self.id = UUID()
    self.hue = hue
    self.saturation = saturation
    self.brightness = brightness
    self.alpha = alpha
    self.name = name
  }
  public init(
    h: Double,
    s: Double,
    v: Double,
    alpha: Double = 1.0,
    name: String? = nil
  ) {
    self.init(hue: h, saturation: s, brightness: v, alpha: alpha, name: name)
  }
}

extension HSVColour {

  public var toColour: Color {
    Color(
      hue: hue,
      saturation: saturation,
      brightness: brightness,
      opacity: alpha
    )
  }

  /// Hue is only meaningful when there is chroma and not pure black.
  /// (You can decide whether `brightness == 0` should count as undefined even if saturation > 0;
  /// practically it behaves as undefined because it round-trips poorly.)
  public var isHueDefined: Bool {
    /// If you’d rather allow hue when brightness == 0 (mathematically it’s
    /// still not observable), change to saturation > 0.
    saturation > 0 && brightness > 0
  }
  
  

  /// Returns `incoming`, but if its hue is undefined (grey/black), preserves `self.hue`.
  public func mergingPreservingHue(_ incoming: HSVColour) -> HSVColour {
    guard incoming.isHueDefined else {
      var result = incoming
      result.hue = self.hue
      return result
    }
    return incoming
  }

  public var hueOnly: Self {
    Self(
      hue: hue,
      saturation: 1.0,
      brightness: 1.0,
      alpha: 1.0,
    )
  }
  public var hueSatOnly: Self {
    Self(
      hue: hue,
      saturation: saturation,
      brightness: 1.0,
      alpha: 1.0,
    )
  }
  
  public var toOpaque: HSVColour {
    HSVColour(h: hue, s: saturation, v: brightness, alpha: 1.0, name: name)
  }

  /// Convert to RGB and back again while preserving hue across undefined-hue zones.
  /// Useful when RGB is your bound storage but HSV drives interaction.
  public func toRGBPreservingHueRoundTrip(
    from previous: HSVColour?
  ) -> (rgb: RGBColour, hsv: HSVColour) {
    let rgb = self.toRGB
    let hsv = rgb.toHSV(preservingHueFrom: previous)
    return (rgb, hsv)
  }

  public var toRGB: RGBColour { RGBColour(fromHSV: self) }

  public static func gray(
    _ brightness: Double,
    alpha: Double = 1.0,
  ) -> HSVColour {
    return HSVColour(
      hue: 0,
      saturation: 0,
      brightness: brightness,
      alpha: alpha,
      name: "Gray"
    )
  }

  /// This is handled in ``HSVAdjustable/adjust(by:)``
  //  func applying(adjustment: HSVAdjustment) -> HSVColour {
  //    let adjustedHue = adjustment.hue.map { hue + $0 } ?? hue
  //
  //    let adjustedSaturation =
  //      adjustment.saturation.map { saturation + $0 } ?? saturation
  //
  //    let adjustedBrightness =
  //      adjustment.brightness.map { brightness + $0 } ?? brightness
  //
  //    return HSVColour(
  //      hue: adjustedHue,
  //      saturation: adjustedSaturation,
  //      brightness: adjustedBrightness,
  //      alpha: alpha,
  //      name: self.name
  //    )
  //  }
}

//
//public func + (lhs: HSVColour, rhs: HSVAdjustment) -> HSVColour {
//  lhs.applying(adjustment: rhs)
//}

extension HSVColour: CustomStringConvertible {
  public var description: String {
    let result = """
      HSVColour[H: \(hue), S: \(saturation), V: \(brightness), Name: \(name ?? "nil")]
      """

    return result
  }
}
