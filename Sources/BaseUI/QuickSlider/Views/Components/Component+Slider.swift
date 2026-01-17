//
//  Component+Slider.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/1/2026.
//

import SwiftUI

struct Component_Slider: View {
  @Environment(\.sliderStyle) private var style
  @Environment(\.sliderComponents) private var sliderComponents
  @Environment(\.sliderHandler) private var store
  @Environment(\.sliderDefaultValue) private var defaultValue

  //  @Binding var value: Double
//  let style: SliderStyle

  var body: some View {
    @Bindable var store = store

    switch style {
      // MARK: - Native Slider
      case .native:
        if sliderComponents.contains(.label) {
          NativeSliderComponent()
        } else {
          NativeSliderComponent()
            .labelsHidden()
        }

      // MARK: - Custom Slider
      case .custom(let style):
        SliderCustom(style: style) {
          if sliderComponents.contains(.label) {
            LabelComponent()
          } else {
            EmptyView()
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
      in: store.range.toDoubleRange,
    ) {
      LabelComponent()

    } onEditingChanged: { editing in
      let phase = SliderPhase(fromOnEditingChanged: editing)
      store.phase = phase
      store.didChangeSlider?(phase)
//      store.triggerDidChangeSlider(phase)
    }
  }

  @ViewBuilder
  func LabelComponent() -> some View {
    @Bindable var store = store
    MaybeLabel(store.label)
      .onDoubleTap($store.value, defaultValue: defaultValue)
      .font(.body)
    //      .lineLimit(1)

    /// This can cause fuzzy text, in certain situations
    //      .fixedSize(horizontal: true, vertical: false)
  }
}
