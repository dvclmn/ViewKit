//
//  TrackStyle.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/3/2026.
//

import SwiftUI

public struct SliderTrackConfiguration {
  public enum Orientation { case horizontal, vertical }
  
  // Slider value and range normalized if you prefer (0...1),
  // or keep the original range if that’s more useful.
  public var value: Double
  public var range: ClosedRange<Double>
  
  public var isEnabled: Bool
  public var orientation: Orientation
  public var size: CGSize
  
  // Environment/context
  public var colorScheme: ColorScheme
  public var tint: Color
  
  public init(
    value: Double,
    range: ClosedRange<Double>,
    isEnabled: Bool,
    orientation: Orientation,
    size: CGSize,
    colorScheme: ColorScheme,
    tint: Color
  ) {
    self.value = value
    self.range = range
    self.isEnabled = isEnabled
    self.orientation = orientation
    self.size = size
    self.colorScheme = colorScheme
    self.tint = tint
  }
}
