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
  @Environment(\.isDebugMode) private var isDebugMode

  var body: some View {
    @Bindable var store = store

    switch sliderStyle {
      // MARK: - Native Slider
      case .native:
        if sliderComponents.contains(.label) {
          LabelComponent()
          NativeSliderComponent()
            .debugFrame("Native + Label", .green, isEnabled: isDebugMode)

        } else {
          NativeSliderComponent()
            .labelsHidden()
            .debugFrame("Native + NO Label", .orange, isEnabled: isDebugMode)
        }

      // MARK: - Custom Slider
      case .custom(let style):
        SliderCustom(style: style) {
          if sliderComponents.contains(.label) {
            LabelComponent()
              .debugFrame("Custom + Label", .pink, isEnabled: isDebugMode)
          }
        }

    }
  }
}

extension Component_Slider {

  @ViewBuilder
  func NativeSliderComponent() -> some View {
    @Bindable var store = store
    
    if let step = store.step {
      Slider(
        value: $store.value,
        in: store.range,
        step: store.step ?? 1
      ) { editing in
        let phase = SliderPhase(fromOnEditingChanged: editing)
        store.updatePhase(phase)
        //      store.phase = phase
        //      store.didChangeSlider?(phase)
      }
    } else {
      Slider(
        value: $store.value,
        in: store.range,
        step: store.step ?? 1
      ) { editing in
        let phase = SliderPhase(fromOnEditingChanged: editing)
        store.updatePhase(phase)
        //      store.phase = phase
        //      store.didChangeSlider?(phase)
      }
    }

  }

  @ViewBuilder
  func LabelComponent() -> some View {
    @Bindable var store = store
    MaybeLabel(store.label)
    //      .onDoubleTap($store.value, defaultValue: sliderDefaultValue)
    //      .font(.body)
    //      .lineLimit(1)

    /// This can cause fuzzy text, in certain situations
    //      .fixedSize(horizontal: true, vertical: false)
  }
}
