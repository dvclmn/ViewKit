//
//  Codable+Ext.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/11/2025.
//

import SwiftUI

extension Color {
  init(codableColour: SystemColour) {
    self =
      switch codableColour {
        case .black: .black
        case .blue: .blue
        case .brown: .brown
        case .clear: .clear
        case .cyan: .cyan
        case .gray: .gray
        case .green: .green
        case .indigo: .indigo
        case .mint: .mint
        case .orange: .orange
        case .pink: .pink
        case .purple: .purple
        case .red: .red
        case .teal: .teal
        case .white: .white
        case .yellow: .yellow
        case .primary: .primary
        case .secondary: .secondary
        case .accentColor: .accentColor
      }
  }
}

extension CodableColour {

  public var colour: Color? {
    switch self {
      case .hex(let hex, let opacity):
        return Color(hex: hex)?.opacity(opacity)

      case .rgb(let model):
        return Color(
          red: model.red,
          green: model.green,
          blue: model.blue,
          opacity: model.alpha
        )

      case .rgbRaw(let r, let g, let b, let opacity):
        return Color(
          Color.RGBColorSpace.sRGB,
          red: r,
          green: g,
          blue: b,
          opacity: opacity
        )

      case .hsv(let model):
        //        return model.toColour
        return Color(
          hue: model.hue,
          saturation: model.saturation,
          brightness: model.brightness,
          opacity: model.alpha
        )
      case .hsvRaw(let h, let s, let v, let opacity):
        //      case .hsv(let model):
        //        return model.toColour
        return Color(
          hue: h,
          saturation: s,
          brightness: v,
          opacity: opacity
        )

      case .grey(let v, let opacity):
        return Color(
          hue: 0,
          saturation: 0,
          brightness: v,
          opacity: opacity
        )

      case .system(let system, let opacity):
        return system.toColour.opacity(opacity)

      case .mix(let a, let b, let t, let opacity):
        return ColourMix(a, b, mixAmount: t).colour.opacity(opacity)
    }
  }
}
