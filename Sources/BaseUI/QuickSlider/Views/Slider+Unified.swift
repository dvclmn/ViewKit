//
//  Slider+Unified.swift
//  BaseComponents
//
//  Created by Dave Coleman on 11/8/2025.
//

import SwiftUI
import SharedHelpers

public struct SliderUnified: View {
  @Environment(\.sliderControlSize) private var controlSize
  @Environment(\.sliderComponents) private var sliderComponents

  @Environment(\.sliderRange) private var range
  @Environment(\.sliderLabel) private var label
  @Environment(\.sliderDefaultValue) private var defaultValue

  @Environment(\.explicitHeight) private var explicitHeight
  @Environment(\.cornerRounding) private var cornerRounding
  @Environment(\.trackComponents) private var trackComponents

  @State private var isHovering: Bool = false

  @Binding var value: Double
  @Binding var store: SliderHandler
  let type: SliderType

  public var body: some View {

    GridRow {
      HStack {
        // MARK: - Slider
        if sliderComponents.contains(.slider) {

          SliderComponent()
            .frame(minWidth: 80)
            .sensoryFeedback(.alignment, trigger: value) {
              oldValue,
              newValue in

              HapticPreset.boundaryReached.hapticPreset(
                for: range,
                with: defaultValue,
                oldValue,
                newValue
              )
            }
            .controlSize(controlSize)
        }

        // MARK: - Units
        if sliderComponents.contains(.units) {
          UnitsComponent()
        }
      }
    }  // END grid row

  }
}
extension SliderUnified {

  @ViewBuilder
  func LabelComponent() -> some View {
    MaybeLabel(label)
      .onDoubleTap($value, defaultValue: defaultValue)
      .font(.body)
    //      .lineLimit(1)

    /// This can cause fuzzy text, in certain situations
    //      .fixedSize(horizontal: true, vertical: false)
  }

  @ViewBuilder
  func SliderComponent() -> some View {

    switch type {
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
        SliderCustom(
          value: $value,
          store: $store,
          style: style
        ) {
          if sliderComponents.contains(.label) {
            LabelComponent()
          } else {
            EmptyView()
          }
        }
    }
  }

  @ViewBuilder
  func UnitsComponent() -> some View {
    TextColumns {
      if let formatted = store.formatValue?(value) {
        Text(formatted)
      } else {
        Text(value.displayString)
      }
    }
    .textSelection(.disabled)
    .onDoubleTap($value, defaultValue: defaultValue)

  }

  @ViewBuilder
  func NativeSliderComponent() -> some View {
    Slider(
      value: $value,
      in: range
    ) {
      LabelComponent()

    } onEditingChanged: { editing in
      let phase = SliderPhase(fromOnEditingChanged: editing)
      store.phase = phase
      store.triggerDidChangeSlider(phase)
    }
  }

}
