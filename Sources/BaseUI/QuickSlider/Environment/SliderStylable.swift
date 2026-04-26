//
//  SliderStylable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/4/2026.
//

import SwiftUI

/// This is in use by e.g. `QuickSlider`, `LabeledSlider`
public protocol SliderStylable {}

/// Allows preservation of a View's type across modifiers.
/// Rather than losing this context via opaque `some View`.
/// Caveat: must use a full ViewModifier, not just e.g `environment`
/// inline in the View extension.
extension ModifiedContent: SliderStylable where Content: SliderStylable {}

extension View where Self: SliderStylable {

  public func sliderTrackStyle<S: SliderTrackStyle>(
    _ style: S,
    maxWidth: CGFloat? = nil,
  ) -> ModifiedContent<Self, SliderStyleModifier<S>> {
    modifier(SliderStyleModifier(style: style, maxWidth: maxWidth))
  }

  /// Max width for the track component
  public func sliderMaxWidth(_ width: CGFloat) -> some View {
    self.environment(\.sliderTrackMaxWidth, width)
  }

  public func sliderComponents(
    _ components: SliderComponents = .all
  ) -> ModifiedContent<Self, SliderComponentsModifier> {
    modifier(SliderComponentsModifier(components: components))
  }

  public func stepStyle(_ style: StepStyle) -> some View {
    self.environment(\.stepStyle, style)
  }

}
