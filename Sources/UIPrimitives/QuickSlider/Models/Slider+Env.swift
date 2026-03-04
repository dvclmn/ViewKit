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
  @Entry public var sliderDefaultValue: Double?
  @Entry public var sliderStyle: SliderStyle = .native
  @Entry public var stepStyle: StepStyle?

  @Entry var sliderTrackStyle: AnySliderTrackStyle = .init()
  
  @Entry var isWithinSliderGroup: Bool = false

}

extension View {
  public func sliderTrackStyle<S: SliderTrackStyle>(_ style: S) -> some View {
    environment(\.sliderTrackStyle, AnySliderTrackStyle(style))
  }
}


/// This is in use by e.g. `QuickSlider`, `LabeledSlider`
public protocol SliderStylable {}

extension View {
//extension View where Self: SliderStylable {
  public func sliderStyle(_ style: SliderStyle = .native) -> some View {
    self.environment(\.sliderStyle, style)
  }

  public func sliderComponents(_ components: SliderComponents = .all) -> some View {
    self.environment(\.sliderComponents, components)
  }

  public func stepStyle(_ style: StepStyle) -> some View {
    self.environment(\.stepStyle, style)
  }

}
