//
//  SliderStyleModifiers.swift
//  ViewKit
//
//  Created by Dave Coleman on 23/4/2026.
//

import SwiftUI

public struct SliderStyleModifier<S: SliderTrackStyle>: ViewModifier {
  let style: S
  let maxWidth: CGFloat?
  public func body(content: Content) -> some View {
    content
      .environment(\.sliderTrackStyle, AnySliderTrackStyle(style))
      .environment(\.sliderTrackMaxWidth, maxWidth)
  }
}

public struct SliderComponentsModifier: ViewModifier {
  let components: SliderComponents
  public func body(content: Content) -> some View {
    content.environment(\.sliderComponents, components)
  }
}

public struct SliderStepStyleModifier: ViewModifier {
  let style: StepStyle
  public func body(content: Content) -> some View {
    content.environment(\.stepStyle, style)
  }
}
