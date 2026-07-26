//
//  TrackStyle.swift
//  ViewKit
//
//  Created by Dave Coleman on 4/3/2026.
//

import SwiftUI

/// The value and display context used to create an AppKit slider track.
public struct SliderTrackConfiguration {

  /// The slider's current bound value.
  public var value: Double
  /// The complete range accepted by the slider.
  public var range: ClosedRange<Double>

  /// The colour scheme active when the track is drawn.
  public var colorScheme: ColorScheme
  /// The current SwiftUI accent tint.
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
