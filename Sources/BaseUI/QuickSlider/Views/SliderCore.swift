//
//  Component+Slider.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/1/2026.
//

import SwiftUI

extension QuickSlider {
  struct SliderCore: View {
    @Environment(SliderHandler.self) private var store
    @Environment(\.sliderDefaultValue) private var sliderDefaultValue
    @Environment(\.colorScheme) private var colourScheme
    @Environment(\.isASCIIMode) private var isASCIIMode
    @Environment(\.unitSize) private var unitSize
    @Environment(\.stepStyle) private var stepStyle

    @Binding var value: Double
    let track: TrackBackground
    var body: some View {

      if isASCIIMode, let unitSize {

        Text("Not yet implemented. Unit size is: \(unitSize, default: "nil")")
        //        TextSliderCore(
        //          value: value,
        //          unitSize: unitSize
        //        )

      } else {

        /// If there's a track, then it's a Custom Slider
        if let track = track(store.trackConfiguration(value: value, colourScheme: colourScheme)) {
          // MARK: - Custom Slider
          SliderCustom(value: $value, track: track)

        } else {

          // MARK: - Native Slider

          /// Using `labelsHidden` as Label is handled in ``SliderComponents``
          @Bindable var store = store

          if let step = store.step {
            StepperView(step)

            Slider(
              value: $value,
              in: store.range,
              step: step,
            ) {
              SliderLabel(value: $value)

            } onEditingChanged: { editing in
              handleOnEdit(editing)
            }
            .labelsHidden()

          } else {

            Slider(
              value: $value,
              in: store.range,
            ) {
              SliderLabel(value: $value)

            } onEditingChanged: { editing in
              handleOnEdit(editing)
            }
            .labelsHidden()
          }
        }
      }

    }
  }
}

extension QuickSlider.SliderCore {

  @ViewBuilder
  private func StepperView(_ step: Double) -> some View {
    if stepStyle == .stepper {
      //    if let step = store.step, stepStyle == .stepper {
      Stepper(
        store.label.text,
        value: $value,
        step: step,
      )
      .labelsHidden()
    }
  }

  private var columns: Int { store.sliderTrackColumns }

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
