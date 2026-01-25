//
//  SliderEnvironment.swift
//  BaseComponents
//
//  Created by Dave Coleman on 29/5/2025.
//

import BasePrimitives
import SwiftUI

/// These are `QuickSlider` specific, and should replace what was
/// previously handled by `@StyleConfig`.
///
/// It may be that some of these could be useful for inclusion
/// in the global values as well.
extension EnvironmentValues {
  @Entry public var sliderComponents: SliderComponents = .all

  @Entry public var sliderDefaultValue: Double? = nil
  @Entry public var sliderStyle: SliderStyle = .native

  @Entry var isWithinSliderGroup: Bool = false

  @Entry var sliderHandler: SliderHandler = .init(
    value: 1.0,
    label: "",
    range: 0...1,
    step: nil,
    didChangeSlider: { _ in }
  )
}

/// This is in use by e.g. `QuickSlider`, `LabeledSlider`
public protocol SliderStylable {}

extension View where Self: SliderStylable {
  public func sliderStyle(
    _ style: SliderStyle = .native,
    components: SliderComponents = .all
  ) -> some View {
    self.environment(\.sliderStyle, style)
      .environment(\.sliderComponents, components)
  }
}
