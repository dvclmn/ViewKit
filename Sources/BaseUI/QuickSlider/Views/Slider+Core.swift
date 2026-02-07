//
//  Slider+Unified.swift
//  BaseComponents
//
//  Created by Dave Coleman on 11/8/2025.
//

import BasePrimitives
import SwiftUI

public struct SliderCore: View {
  @Environment(SliderHandler.self) private var store
  @Environment(\.controlSizeOverride) private var controlSizeOverride
  @Environment(\.sliderComponents) private var sliderComponents

  @Environment(\.stepStyle) private var stepStyle
  @Environment(\.formatValue) private var formatValue
  @Environment(\.sliderDefaultValue) private var sliderDefaultValue
  @Environment(\.isDebugMode) private var isDebugMode

  @State private var isHovering: Bool = false

  public var body: some View {
    @Bindable var store = store

    // MARK: - Units
    if sliderComponents.contains(.label) {
      LabelComponent()
    }

    if let step = store.step {
      switch stepStyle {
        case .native:
          SliderTrackNativeView(step: step)

        case .stepper:
          HStack {
            SliderTrackNativeView(step: nil)

            Stepper(
              store.label.text,
              value: $store.value,
              step: step,
            )
            .labelsHidden()
          }

        case .none:
          SliderTrackNativeView(step: nil)
      }

    } else {
      SliderTrackNativeView(step: nil)
    }

    // MARK: - Units
    if sliderComponents.contains(.units) {
      TextColumns(alignment: .trailing) {
        Text(formatValue(store.value))
      }
      .textSelection(.disabled)
      .onDoubleTap($store.value.toBindingDouble, defaultValue: sliderDefaultValue)
      .contextMenu { ContextMenuItems() }
    }
  }
}

extension SliderCore {

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
      copyStringToClipboard(store.value.toString)
    } label: {
      Label("Copy", systemImage: Icons.copy.icon)
    }

    if let sliderDefaultValue {
      Divider()
      Button {
        store.value = sliderDefaultValue
      } label: {
        Label("Reset to Default", systemImage: Icons.refresh.icon)
      }
    }
  }

  @ViewBuilder
  func LabelComponent() -> some View {
    @Bindable var store = store
    MaybeLabel(store.label)
      .onDoubleTap($store.value.toBindingDouble, defaultValue: sliderDefaultValue)
  }
}
