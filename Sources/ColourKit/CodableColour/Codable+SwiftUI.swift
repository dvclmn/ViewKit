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
      case .hex(let hex):
        return Color(hex: hex)

      case .rgb(let model):
        return Color(
          red: model.red,
          green: model.green,
          blue: model.blue,
          opacity: model.alpha
        )

      case .rgbRaw(let r, let g, let b):
        return Color(
          Color.RGBColorSpace.sRGB,
          red: r,
          green: g,
          blue: b
        )

      case .hsv(let model):
        //        return model.toColour
        return Color(
          hue: model.hue,
          saturation: model.saturation,
          brightness: model.brightness,
          opacity: 1.0
        )
      case .hsvRaw(let h, let s, let v):
        //      case .hsv(let model):
        //        return model.toColour
        return Color(
          hue: h,
          saturation: s,
          brightness: v,
          opacity: 1.0
        )

      case .grey(let v):
        return Color(
          hue: 0,
          saturation: 0,
          brightness: v,
          opacity: 1.0
        )

      case .system(let system):
        return system.toColour

      case .mix(let a, let b, let t):
        return ColourMix(a, b, mixAmount: t).colour
    }
  }
}
