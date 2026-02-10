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

    @Binding var value: Double
    let step: Double?

    var body: some View {

      switch sliderStyle {

        // MARK: - Native Slider
        case .native:
          @Bindable var store = store

          Group {
            if let step {
              Slider(
                value: $value,
                in: store.range,
                step: step
              ) { editing in
                handleOnEdit(editing)
              }
            } else {
              Slider(
                value: $value,
                in: store.range,
              ) { editing in
                handleOnEdit(editing)
              }
            }
          }
          .labelsHidden()

        // MARK: - Custom Slider
        case .custom(let style):
          SliderCustom(
            value: $value,
            style: style
          )

      }
    }
  }
}

extension QuickSlider.SliderCore {
//  private var sliderRange: ClosedRange<Double> {
//    Value(store.range.lowerBound)...Value(store.range.upperBound)
//  }

  private func handleOnEdit(_ didEdit: Bool) {
    let phase = SliderPhase(fromOnEditingChanged: didEdit)
    store.updatePhase(phase)
  }
}
