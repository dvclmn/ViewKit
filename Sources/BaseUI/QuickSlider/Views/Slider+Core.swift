//
//  Slider+Unified.swift
//  BaseComponents
//
//  Created by Dave Coleman on 11/8/2025.
//

import CoreTools
import SwiftUI

extension QuickSlider {
  struct SliderCore: View {
  @Environment(SliderHandler.self) private var store
  @Environment(\.controlSizeOverride) private var controlSizeOverride
  @Environment(\.sliderComponents) private var sliderComponents

  @Environment(\.stepStyle) private var stepStyle
  @Environment(\.formatValue) private var formatValue
  @Environment(\.sliderDefaultValue) private var sliderDefaultValue
  @Environment(\.isDebugMode) private var isDebugMode

  @State private var isHovering: Bool = false

  @Binding var value: Value
  
  var body: some View {
    @Bindable var store = store

    // MARK: - Units
    if sliderComponents.contains(.label) {
      LabelComponent()
    }

    if let step = store.step {
      switch stepStyle {
        case .native:
          SliderTrackNativeView(value: $value, step: Value.Stride(step))

        case .stepper:
          HStack {
            SliderTrackNativeView(value: $value, step: nil)

            Stepper(
              store.label.text,
              value: $value,
              step: Value.Stride(step),
            )
            .labelsHidden()
          }

        case .none:
          SliderTrackNativeView(value: $value, step: nil)
      }

    } else {
      SliderTrackNativeView(value: $value, step: nil)
    }

    // MARK: - Units
    if sliderComponents.contains(.units) {
      TextColumns(alignment: .trailing) {
        Text(formatValue(value.toDouble))
      }
      .textSelection(.disabled)
      .onDoubleTap($value, defaultValue: sliderDefault)
      .contextMenu { ContextMenuItems() }
    }
  }
}
}

extension QuickSlider.SliderCore {

  private var sliderDefault: Value? {
    sliderDefaultValue.map { Value($0) }
  }

  private var columnSpan: Int { sliderComponents.count }

  private func handleHaptics(_ old: Double, _ new: Double) -> Bool {
    guard let defaultVal = sliderDefaultValue else {
      return HapticPreset.boundary(store.range.toDoubleRange).shouldFire(old, new)
    }
    return HapticPreset.boundaryAndDefault(store.range.toDoubleRange, defaultValue: defaultVal).shouldFire(
      old, new)
  }

  @ViewBuilder
  private func ContextMenuItems() -> some View {
    Button {
      copyStringToClipboard("\(value)")
    } label: {
      Label("Copy", systemImage: Icons.copy.icon)
    }

    if let sliderDefault {
      Divider()
      Button {
        value = sliderDefault
      } label: {
        Label("Reset to Default", systemImage: Icons.refresh.icon)
      }
    }
  }

  @ViewBuilder
  func LabelComponent() -> some View {
    @Bindable var store = store
    MaybeLabel(store.label)
      .onDoubleTap($value.toBindingDouble, defaultValue: sliderDefaultValue)
  }
}
