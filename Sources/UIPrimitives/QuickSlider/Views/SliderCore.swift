//
//  Component+Slider.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/1/2026.
//

import CoreTools
import SwiftUI

extension QuickSlider {
  struct SliderCore: View {
    @Environment(SliderHandler.self) private var store
    @Environment(\.sliderStyle) private var sliderStyle
    @Environment(\.sliderDefaultValue) private var sliderDefaultValue

    @Binding var value: Double

    var body: some View {

      switch sliderStyle {

        // MARK: - Native Slider
        case .native:
          @Bindable var store = store

          Group {
            if let step = store.step {
              Slider(
                value: $value,
                in: store.range,
                step: step
              ) {
                //                EmptyView()
                LabelComponent()

                //              } minimumValueLabel: {
                //                MinMaxLabel(.min)
                //
                //              } maximumValueLabel: {
                //                MinMaxLabel(.max)

              } onEditingChanged: { editing in
                handleOnEdit(editing)
              }

            } else {

              Slider(
                value: $value,
                in: store.range,
              ) {

                LabelComponent()

                //              } minimumValueLabel: {
                //                MinMaxLabel(.min)
                //
                //              } maximumValueLabel: {
                //                MinMaxLabel(.max)
                //
              } onEditingChanged: { editing in
                handleOnEdit(editing)
              }
            }
          }
          .labelsHidden()

        // MARK: - Custom Slider
        case .custom(let style):
          SliderCustom(value: $value, style: style)
      }
    }
  }
}

extension QuickSlider.SliderCore {

  @ViewBuilder
  func LabelComponent() -> some View {
    @Bindable var store = store
    MaybeLabel(store.label)
      .onDoubleTap($value.toBindingDouble, defaultValue: sliderDefaultValue)
  }

  @ViewBuilder
  private func MinMaxLabel(_ label: MinMaxLabel) -> some View {
    if let value = label.value(from: store) {
      Image(systemName: value)
    } else {
      Image(systemName: "eye")
        .hidden()
    }
  }

  private func handleOnEdit(_ didEdit: Bool) {
    let phase = SliderPhase(fromOnEditingChanged: didEdit)
    store.updatePhase(phase)
  }
}

enum MinMaxLabel {
  case min
  case max

  func value(from store: SliderHandler) -> String? {
    fatalError("Not currently implemented")
    //    switch self {
    //      case .min: store.minMaxLabels?.0
    //      case .max: store.minMaxLabels?.1
    //    }
  }
}
