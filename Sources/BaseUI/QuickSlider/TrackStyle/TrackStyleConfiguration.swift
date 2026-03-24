//
//  TrackStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/3/2026.
//

import SwiftUI

public struct SliderTrackConfiguration {

  public var value: Double
  public var range: ClosedRange<Double>

  //  public var isEnabled: Bool
  //  public var size: CGSize

  /// Environment/context
  public var colorScheme: ColorScheme
  public var tint: Color

  public init(
    value: Double,
    range: ClosedRange<Double>,
    //    isEnabled: Bool,
    //    size: CGSize,
    colorScheme: ColorScheme,
    tint: Color
  ) {
    self.value = value
    self.range = range
    //    self.isEnabled = isEnabled
    //    self.size = size
    self.colorScheme = colorScheme
    self.tint = tint
  }
}
