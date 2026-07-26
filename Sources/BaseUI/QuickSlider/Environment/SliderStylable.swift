//
//  SliderStylable.swift
//  ViewKit
//
//  Created by Dave Coleman on 23/4/2026.
//

import SwiftUI

/// Marks views that support QuickSlider presentation modifiers.
public protocol SliderStylable {}

/// Preserves `SliderStylable` through its dedicated ViewModifiers.
extension ModifiedContent: SliderStylable where Content: SliderStylable {}

extension View where Self: SliderStylable {
  /// Limits the width assigned to the central slider control.
  public func sliderMaxWidth(
    _ width: CGFloat
  ) -> ModifiedContent<Self, SliderMaxWidthModifier> {
    modifier(SliderMaxWidthModifier(width: width))
  }

  /// Selects which labelled-control components are visible.
  public func sliderComponents(
    _ components: SliderComponents = .all
  ) -> ModifiedContent<Self, SliderComponentsModifier> {
    modifier(SliderComponentsModifier(components: components))
  }

  /// Chooses the supplemental presentation for a stepped slider.
  public func stepStyle(
    _ style: StepStyle
  ) -> ModifiedContent<Self, SliderStepStyleModifier> {
    modifier(SliderStepStyleModifier(style: style))
  }

}
