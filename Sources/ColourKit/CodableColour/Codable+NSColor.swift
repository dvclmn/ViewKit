//
//  Codable+NSColor.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/11/2025.
//

#if canImport(AppKit)
import AppKit

extension CodableColour {
  public func nsColor(fallback: NSColor) -> NSColor {
//  public func nsColor(fallback: NSColor = .textColor) -> NSColor {
    return self.nsColor ?? fallback
  }

  public var nsColor: NSColor? {
    switch self {
      case .hex(let hex):
        return NSColor.fromHexString(hex)

      case .rgb(let model):
        return NSColor(
          red: model.red,
          green: model.green,
          blue: model.blue,
          alpha: model.alpha
        )
        
      case .hsv(let model):
        return NSColor(
          hue: model.hue,
          saturation: model.saturation,
          brightness: model.brightness,
          alpha: 1.0
        )

      case .hsvRaw(let h, let s, let v):
        return NSColor(
          hue: h,
          saturation: s,
          brightness: v,
          alpha: 1.0
        )

      case .rgbRaw(let r, let g, let b):
        return NSColor(red: r, green: g, blue: b, alpha: 1.0)

      case .system(let system):
        return system.toNSColor()

      case .grey(let v):
        return NSColor(cgColor: CGColor(gray: v, alpha: 1.0))

      case .mix(let a, let b, let t):
        guard let colorA = a.toNSColor(),
          let colorB = b.toNSColor()
        else { return nil }
        return colorA.blended(withFraction: t, of: colorB)
    }
  }
}
#endif
