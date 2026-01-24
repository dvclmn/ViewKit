//
//  Model+Components.swift
//  BaseComponents
//
//  Created by Dave Coleman on 12/5/2025.
//

import SwiftUI

/// Notes on differences in modelling RGB vs HSV
///
/// For HSV, these aren't "channels" in the same sense as
/// RGB components. They represent different types of color attributes:
///
/// - Hue is an angular dimension (0-360 degrees)
/// - Saturation is a percentage of color intensity (0-100%)
/// - Value/Brightness is a percentage of lightness (0-100%)

//
public enum HSVComponent: String, ColourComponent, Sendable {

  public typealias Model = HSVColour

  case hue
  case saturation
  case brightness
  case alpha

  public var get: (HSVColour) -> Double {
    switch self {
      case .hue: { $0.hue }
      case .saturation: { $0.saturation }
      case .brightness: { $0.brightness }
      case .alpha: { $0.alpha }
    }
  }

  public var set: (inout HSVColour, Double) -> Void {
    switch self {
      case .hue: { $0.hue = Double($1) }
      case .saturation: { $0.saturation = Double($1) }
      case .brightness: { $0.brightness = Double($1) }
      case .alpha: { $0.alpha = Double($1) }
    }
  }

  public var nameInitial: Character {
    switch self {
      case .hue: "H"
      case .saturation: "S"
      case .brightness: "B"
      case .alpha: "A"
    }
  }

  public func gradientColours(_ colour: Model) -> [Color] {
    switch self {
      case .hue: Array<Color>.rainbow
      case .saturation:
        [.gray, colour.toColour]
      case .brightness:
        [.black, .white]
      case .alpha:
        [.clear, colour.toColour]
    }
  }

  public func sliderTrackGradient(colour: HSVColour) -> LinearGradient {
    return LinearGradient(
      colors: self.gradientColours(colour),
      startPoint: .leading,
      endPoint: .trailing
    )
  }

}
