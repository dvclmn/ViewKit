//
//  Component+Slider.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/1/2026.
//

import CoreTools
import SwiftUI

struct Component_Slider: View {
  @Environment(\.sliderStyle) private var sliderStyle
  @Environment(\.sliderComponents) private var sliderComponents
  @Environment(\.sliderHandler) private var store
  @Environment(\.sliderDefaultValue) private var sliderDefaultValue

  let isInternalDebugMode: Bool = true

  var body: some View {
    @Bindable var store = store

    switch sliderStyle {
      // MARK: - Native Slider
      case .native:
        if sliderComponents.contains(.label) {
          NativeSliderComponent()
            .debugFrame("Native + Label", .green, isEnabled: isInternalDebugMode)

        } else {
          NativeSliderComponent()
            .labelsHidden()
            .debugFrame("Native + NO Label", .orange, isEnabled: isInternalDebugMode)
        }

      // MARK: - Custom Slider
      case .custom(let style):
        SliderCustom(style: style) {
          if sliderComponents.contains(.label) {
            LabelComponent()
              .debugFrame("Custom + Label", .pink, isEnabled: isInternalDebugMode)
          } else {
            EmptyView()
              .debugFrame("Custom + NO Label", .purple, isEnabled: isInternalDebugMode)
          }
        }
        
    }
  }
}

extension Component_Slider {

  @ViewBuilder
  func NativeSliderComponent() -> some View {
    @Bindable var store = store
    Slider(
      value: $store.value,
      in: store.range,
    ) {
      LabelComponent()

    } onEditingChanged: { editing in
      let phase = SliderPhase(fromOnEditingChanged: editing)
      store.updatePhase(phase)
      //      store.phase = phase
      //      store.didChangeSlider?(phase)
    }
  }

  @ViewBuilder
  func LabelComponent() -> some View {
    @Bindable var store = store
    MaybeLabel(store.label)
      .onDoubleTap($store.value, defaultValue: sliderDefaultValue)
      .font(.body)
    //      .lineLimit(1)

    /// This can cause fuzzy text, in certain situations
    //      .fixedSize(horizontal: true, vertical: false)
  }
}
