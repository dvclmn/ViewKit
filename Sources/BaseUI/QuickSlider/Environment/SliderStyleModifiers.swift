//
//  SliderStyleModifiers.swift
//  ViewKit
//
//  Created by Dave Coleman on 23/4/2026.
//

import SwiftUI

/// Supplies a maximum control width to a QuickSlider view.
public struct SliderMaxWidthModifier: ViewModifier {
  let width: CGFloat

  public func body(content: Content) -> some View {
    content.environment(\.sliderTrackMaxWidth, width)
  }
}

/// Supplies a shared ``SliderComponents`` selection to a QuickSlider view.
public struct SliderComponentsModifier: ViewModifier {
  let components: SliderComponents
  public func body(content: Content) -> some View {
    content.environment(\.sliderComponents, components)
  }
}

/// Supplies a supplemental stepped-control style to a QuickSlider view.
public struct SliderStepStyleModifier: ViewModifier {
  let style: StepStyle

  public func body(content: Content) -> some View {
    content.environment(\.stepStyle, style)
  }
}
