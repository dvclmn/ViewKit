//
//  HSV+Luminance.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/2/2026.
//

extension HSVColour: LuminanceReadable {

  /// This relies on RGBColour's `LuminanceReadable` conformance
  public func luminance(using method: LuminanceMethod = .wcag) -> Double {
    RGBColour(fromHSV: self).luminance(using: method)
  }

  public func luminanceThreshold(using method: LuminanceMethod) -> LuminanceThreshold {
    RGBColour(fromHSV: self).luminanceThreshold(using: method)
  }
}
