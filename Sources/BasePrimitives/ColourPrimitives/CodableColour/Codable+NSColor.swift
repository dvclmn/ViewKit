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
      case .hex(let hex, let opacity):
        return NSColor.fromHexString(hex)?.withAlphaComponent(opacity)

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
          alpha: model.alpha
        )

      case .hsvRaw(let h, let s, let v, let opacity):
        return NSColor(
          hue: h,
          saturation: s,
          brightness: v,
          alpha: opacity
        )

      case .rgbRaw(let r, let g, let b, let opacity):
        return NSColor(red: r, green: g, blue: b, alpha: opacity)

      case .system(let system, let opacity):
        guard opacity != 1 else {
          return system.toNSColor
        }
        return system.toNSColor?.withAlphaComponent(opacity)

      case .grey(let v, let opacity):
        return NSColor(cgColor: CGColor(gray: v, alpha: opacity))

      case .mix(let a, let b, let t, let opacity):
        guard let colorA = a.toNSColor,
          let colorB = b.toNSColor
        else { return nil }
        return colorA.blended(withFraction: t, of: colorB)?.withAlphaComponent(opacity)
    }
  }
}
#endif
