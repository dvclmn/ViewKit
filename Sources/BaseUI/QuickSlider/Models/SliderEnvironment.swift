//
//  SliderEnvironment.swift
//  BaseComponents
//
//  Created by Dave Coleman on 29/5/2025.
//

import BasePrimitives
import SwiftUI

public typealias FormatValue = (Double) -> String

/// These are `QuickSlider` specific, and should replace what was
/// previously handled by `@StyleConfig`.
///
/// It may be that some of these could be useful for inclusion
/// in the global values as well.
extension EnvironmentValues {
  @Entry public var sliderControlSize: ControlSize = .small
  @Entry public var sliderComponents: SliderComponents = [.label, .slider, .units]
  @Entry public var trackComponents: TrackComponents = [.thumb]

  @Entry public var sliderRange: ClosedRange<Double> = 0...1
  @Entry public var sliderDefaultValue: Double? = nil
  @Entry public var sliderLabel: QuickLabel = QuickLabel("New label")
  //  @Entry public var sliderValueFormat: SliderValueFormat = .plain

  @Entry public var formatValue: FormatValue = { "\($0.displayString)" }
}

/// This is in use by e.g.
public protocol EnvironmentFormattable {}

extension View where Self: EnvironmentFormattable {
  public func formatSliderValue(_ format: @escaping FormatValue) -> some View {
    self.environment(\.formatValue, format)
  }
}

//extension View where Self == QuickSlider {
//  public func setSliderControlSize(_ size: ControlSize) -> some View {
//    self.environment(\.sliderControlSize, size)
//  }
//
//  public func setSliderComponents(_ components: SliderComponents) -> some View {
//    self.environment(\.sliderComponents, components)
//  }
//}
//
//// MARK: - For Slider Groups
//extension View where Self == SliderGroup<QuickSlider> {
//  public func setSliderControlSize(_ size: ControlSize) -> some View {
//    self.environment(\.sliderControlSize, size)
//  }
//
//  public func setSliderComponents(_ components: SliderComponents) -> some View {
//    self.environment(\.sliderComponents, components)
//  }
//}
