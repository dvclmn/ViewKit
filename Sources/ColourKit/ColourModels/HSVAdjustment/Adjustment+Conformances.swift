//
//  Adjustment+Conformances.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/2/2026.
//

import AppKit
import Foundation

extension HSVColour: HSVAdjustable {
  
  public init(fromHSV hsv: HSVColour) {
    self = hsv
  }
  
  public var toHSV: HSVColour { self }
}

extension RGBColour: HSVAdjustable {

  /// Convert to HSV, preserving `previous.hue` when the converted hue is undefined.
  public func toHSV(preservingHueFrom previous: HSVColour?) -> HSVColour {
    let converted = self.toHSV
    guard let previous else { return converted }
    return previous.mergingPreservingHue(converted)
  }

  public var toHSV: HSVColour { HSVColour(fromRGB: self) }

  public init(fromHSV hsv: HSVColour) {
    let nsColor =
      NSColor(
        hue: CGFloat(hsv.hue),
        saturation: CGFloat(hsv.saturation),
        brightness: CGFloat(hsv.brightness),
        alpha: CGFloat(hsv.alpha)
      )
      // fallback if conversion fails
      .usingColorSpace(.deviceRGB) ?? NSColor.systemPink

    self.init(
      r: Double(nsColor.redComponent),
      g: Double(nsColor.greenComponent),
      b: Double(nsColor.blueComponent),
      a: Double(nsColor.alphaComponent),
      name: hsv.name
    )
  }

}


extension RGBColour {
  
  
  
  //  public init(fromHSV hsv: HSVColour) {
  //    /// Normalize hue to `[0, 1]` range, handling negative values
  //    /// Older version, not sure which is better:
  //    /// `let h = hsv.hue - floor(hsv.hue)`
  //    let h = hsv.hue.truncatingRemainder(dividingBy: 1.0)
  //    let s = hsv.saturation
  //    let v = hsv.brightness
  //
  //    /// Early exit for grayscale (no saturation)
  //    guard s > 0 else {
  //      self.init(red: v, green: v, blue: v, alpha: hsv.alpha, name: hsv.name)
  //      return
  //    }
  //
  //    /// Calculate hue segment and fractional part
  //    let hueScaled = h * 6
  //
  //    /// Ensures 0-5 range
  //    let hueSegment = Int(hueScaled) % 6
  //    let f = hueScaled - floor(hueScaled)
  //
  //    /// Calculate intermediate values
  //    let p = v * (1 - s)
  //    let q = v * (1 - f * s)
  //    let t = v * (1 - (1 - f) * s)
  //
  //    let (r, g, b): (Double, Double, Double)
  //
  //    switch hueSegment {
  //      /// Red to Yellow
  //      case 0: (r, g, b) = (v, t, p)
  //
  //      /// Yellow to Green
  //      case 1: (r, g, b) = (q, v, p)
  //
  //      /// Green to Cyan
  //      case 2: (r, g, b) = (p, v, t)
  //
  //      /// Cyan to Blue
  //      case 3: (r, g, b) = (p, q, v)
  //
  //      /// Blue to Magenta
  //      case 4: (r, g, b) = (t, p, v)
  //
  //      /// Magenta to Red
  //      case 5: (r, g, b) = (v, p, q)
  //
  //      /// Fallback (shouldn't occur)
  //      default: (r, g, b) = (v, v, v)
  //    }
  //    self.init(r: r, g: g, b: b, a: hsv.alpha, name: hsv.name)
  //  }
}
