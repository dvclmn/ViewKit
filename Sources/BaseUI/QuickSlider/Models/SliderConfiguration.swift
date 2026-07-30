//
//  SliderConfiguration.swift
//  ViewKit
//
//  Created by Dave Coleman on 26/7/2026.
//

import SwiftUI
import CoreTools

struct SliderConfiguration {
  // Provided when value for `title` is supplied.
  // If label ViewBuilder closure is used, this has no value
  let label: LabelDescriptor?
  let range: ClosedRange<Double>
  let step: Double?
  let neutralValue: Double?
//  let characterSize: CGSize?
  let didChangeSlider: SliderOutput
  
  func trackConfiguration(
    value: Double,
    colourScheme: ColorScheme,
  ) -> SliderTrackConfiguration {
    SliderTrackConfiguration(
      value: value,
      range: range,
      colorScheme: colourScheme,
      tint: .accentColor,
    )
  }
}
