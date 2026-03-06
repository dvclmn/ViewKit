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

  public init(
    fromRGB r: Double,
    g: Double,
    b: Double,
    a: Double,
    name: String?
  ) {

    let nsColor = NSColor(red: r, green: g, blue: b, alpha: a)
    var hue: CGFloat = 0
    var saturation: CGFloat = 0
    var brightness: CGFloat = 0
    var alpha: CGFloat = 0

    /// From the docs:
    /// If NULL is passed in as an argument, the method doesn’t set that value.
    /// This method works only with objects representing colors in the `calibratedRGB`
    /// or `deviceRGB` color space. Sending it to other objects raises an exception.
    nsColor.getHue(
      &hue,
      saturation: &saturation,
      brightness: &brightness,
      alpha: &alpha
    )

    self.init(
      hue: Double(hue),
      saturation: Double(saturation),
      brightness: Double(brightness),
      alpha: Double(alpha),
      name: name
    )

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
