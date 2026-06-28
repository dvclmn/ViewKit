//
//  TrackStyle.swift
//  ViewKit
//
//  Created by Dave Coleman on 4/3/2026.
//

import SwiftUI

public struct SliderTrackConfiguration {

  public var value: Double
  public var range: ClosedRange<Double>

  /// Environment/context
  public var colorScheme: ColorScheme
  public var tint: Color

  public init(
    value: Double,
    range: ClosedRange<Double>,
    colorScheme: ColorScheme,
    tint: Color,
  ) {
    self.value = value
    self.range = range
    self.colorScheme = colorScheme
    self.tint = tint
  }
}
