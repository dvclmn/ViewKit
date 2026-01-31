//
//  Conversions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/6/2025.
//

import AppKit

extension HSVColour {

  /// From existing `RGBColour` instance
  public init(fromRGB rgb: RGBColour) {
    precondition(
      rgb.areAllComponentsNormalised,
      "RGB components but be in normalised 0...1 format for this HSV conversion method")
    self.init(
      fromRGB: rgb.red,
      g: rgb.green,
      b: rgb.blue,
      a: rgb.alpha,
      name: rgb.name
    )
  }

  public init(fromRGB r: Double, g: Double, b: Double, a: Double, name: String?) {

    let nsColor = NSColor(red: r, green: g, blue: b, alpha: a)
    var hue: CGFloat = 0
    var saturation: CGFloat = 0
    var brightness: CGFloat = 0
    var alpha: CGFloat = 0

    nsColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)

    // Handle error (should be rare)
    //      self.init(hue: 0, saturation: 0, brightness: 0, alpha: a, name: name)
    //      return

    self.init(
      hue: Double(hue),
      saturation: Double(saturation),
      brightness: Double(brightness),
      alpha: Double(alpha),
      name: name
    )

    //    let nsColour = NSColor(red: r, green: g, blue: b, alpha: a)
    //    let thing = nsColour.getHue(<#T##hue: UnsafeMutablePointer<CGFloat>?##UnsafeMutablePointer<CGFloat>?#>, saturation: <#T##UnsafeMutablePointer<CGFloat>?#>, brightness: <#T##UnsafeMutablePointer<CGFloat>?#>, alpha: <#T##UnsafeMutablePointer<CGFloat>?#>)
    //
    //    // Ensure inputs are clamped between 0 and 1
    //    let red = max(0, min(1, r))
    //    let green = max(0, min(1, g))
    //    let blue = max(0, min(1, b))
    //
    //    let maxV = max(red, max(green, blue))
    //    let minV = min(red, min(green, blue))
    //    let delta = maxV - minV
    //
    //    var h: Double = 0
    //    var s: Double = 0
    //    let v: Double = maxV // Using 'v' for Value/Brightness to avoid name collision
    //
    //    s = (maxV == 0) ? 0 : (delta / maxV)
    //
    //    if delta == 0 {
    //      h = 0 // Achromatic (gray)
    //    } else {
    //      if maxV == red {
    //        h = (green - blue) / delta + (green < blue ? 6 : 0)
    //      } else if maxV == green {
    //        h = (blue - red) / delta + 2
    //      } else if maxV == blue {
    //        h = (red - green) / delta + 4
    //      }
    //      h /= 6
    //    }
    //
    //    self.init(
    //      hue: h,
    //      saturation: s,
    //      brightness: v,
    //      alpha: a,
    //      name: name
    //    )
  }
  /// From raw RGB components
  //  public init(fromRGB r: Double, g: Double, b: Double, a: Double, name: String?) {
  //
  //    let maxV: Double = max(r, max(g, b))
  //    let minV: Double = min(r, min(g, b))
  //    let delta: Double = maxV - minV
  //
  //    var h: Double = 0
  //    var s: Double = 0
  //    let b: Double = maxV
  //
  //    s = (maxV == 0) ? 0 : (delta / maxV)
  //
  //    if maxV == minV {
  //      h = 0
  //    } else {
  //
  //      if maxV == r {
  //        h = (g - b) / delta + (g < b ? 6 : 0)
  //
  //      } else if maxV == g {
  //        h = (b - r) / delta + 2
  //
  //      } else if maxV == b {
  //        h = (r - g) / delta + 4
  //
  //      }
  //
  //      h /= 6
  //    }
  //
  //    self.init(
  //      hue: h,
  //      saturation: s,
  //      brightness: b,
  //      alpha: a,
  //      name: name
  //    )
  //  }

}

extension RGBColour {

  public init(fromHSV hsv: HSVColour) {
    let nsColor = NSColor(
      hue: CGFloat(hsv.hue),
      saturation: CGFloat(hsv.saturation),
      brightness: CGFloat(hsv.brightness),
      alpha: CGFloat(hsv.alpha)
    ).usingColorSpace(.deviceRGB) ?? NSColor.systemPink // fallback if conversion fails
    
    self.init(
      r: Double(nsColor.redComponent),
      g: Double(nsColor.greenComponent),
      b: Double(nsColor.blueComponent),
      a: Double(nsColor.alphaComponent),
      name: hsv.name
    )
  }
  
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
