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
    @Environment(\.sliderDefaultValue) private var sliderDefaultValue
    @Environment(\.colorScheme) private var colourScheme

    @Binding var value: Double
    let track: TrackBackground
    var body: some View {

      if let track = track(store.trackConfiguration(value: value, colourScheme: colourScheme)) {
        // MARK: - Custom Slider
        SliderCustom(value: $value, track: track)

      } else {

        // MARK: - Native Slider
        @Bindable var store = store

        Group {
          if let step = store.step {
            Slider(
              value: $value,
              in: store.range,
              step: step
            ) {
              LabelComponent()
            } onEditingChanged: { editing in
              handleOnEdit(editing)
            }

          } else {

            Slider(
              value: $value,
              in: store.range,
            ) {
              LabelComponent()
            } onEditingChanged: { editing in
              handleOnEdit(editing)
            }
          }
        }
        .labelsHidden()
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

  private func handleOnEdit(_ didEdit: Bool) {
    let phase = SliderPhase(fromOnEditingChanged: didEdit)
    store.updatePhase(phase)
  }

  // Min Max not in use atm
  @ViewBuilder
  private func MinMaxLabel(_ label: MinMaxLabel) -> some View {
    if let value = label.value(from: store) {
      Image(systemName: value)
    } else {
      Image(systemName: "eye")
        .hidden()
    }
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
