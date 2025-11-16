//
//  Codable+NSColor.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/11/2025.
//

#if canImport(AppKit)
import AppKit

extension CodableColour {

  public var nsColor: NSColor? {
    switch self {
      case .hex(let hex):
        return NSColor(hex: hex)
      case .rgb(let model):
        return NSColor(
          red: model.red,
          green: model.green,
          blue: model.blue,
          alpha: model.alpha
        )
      case .rgbRaw(let r, let g, let b):
        return NSColor(
          sRGBRed: r,
          green: g,
          blue: b,
          alpha: 1.0
        )
      case .hsv(let model):
        return model.toNSColor
      case .system(let system):
        return system.toNSColor
      case .mix(let a, let b, let t):
        guard let colorA = a.toNSColor,
          let colorB = b.toNSColor
        else {
          return nil
        }
        return NSColor.blend(colorA, with: colorB, amount: t)
    }
  }
}

// Helper extension for blending NSColors
extension NSColor {
  static func blend(_ color1: NSColor, with color2: NSColor, amount: Double) -> NSColor {
    let amount = CGFloat(amount)

    // Convert to RGB color space for blending
    guard let rgb1 = color1.usingColorSpace(.sRGB),
      let rgb2 = color2.usingColorSpace(.sRGB)
    else {
      return color1
    }

    return NSColor(
      sRGBRed: rgb1.redComponent * (1 - amount) + rgb2.redComponent * amount,
      green: rgb1.greenComponent * (1 - amount) + rgb2.greenComponent * amount,
      blue: rgb1.blueComponent * (1 - amount) + rgb2.blueComponent * amount,
      alpha: rgb1.alphaComponent * (1 - amount) + rgb2.alphaComponent * amount
    )
  }
}
#endif
