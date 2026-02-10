//
//  Slider+Unified.swift
//  BaseComponents
//
//  Created by Dave Coleman on 11/8/2025.
//

import CoreTools
import SwiftUI

extension QuickSlider {
  struct SliderComponents: View {
    @Environment(SliderHandler.self) private var store
    @Environment(\.sliderComponents) private var sliderComponents

    @Environment(\.stepStyle) private var stepStyle
    @Environment(\.formatValue) private var formatValue
    @Environment(\.sliderDefaultValue) private var sliderDefaultValue
    @Environment(\.isDebugMode) private var isDebugMode

    @State private var isHovering: Bool = false

    @Binding var value: Double

    var body: some View {
      @Bindable var store = store

      // MARK: - Label
      if sliderComponents.contains(.label) {
        LabelComponent()
      }

      // MARK: - Stepper / Main Track
      if let step = store.step {
        StepperView(step)

      } else {
        // MARK: - Main Track
        SliderCore(value: $value, step: nil)
      }

      // MARK: - Units
      if sliderComponents.contains(.units) {
        TextColumns(alignment: .trailing) {
          Text(formatValue(value.toDouble))
        }
        .textSelection(.disabled)
        .onDoubleTap($value, defaultValue: sliderDefaultValue)
        .contextMenu { ContextMenuItems() }
      }
    }
  }
}

extension QuickSlider.SliderComponents {

  //  private var sliderDefault: Double? {
  //    sliderDefaultValue
  //  }

  private var columnSpan: Int {
    let 
    if sliderComponents == [.label, .units] {
      
    }
//    sliderComponents
  }

  private func handleHaptics(_ old: Double, _ new: Double) -> Bool {
    guard let defaultVal = sliderDefaultValue else {
      return HapticPreset.boundary(store.range.toDoubleRange).shouldFire(old, new)
    }
    return HapticPreset.boundaryAndDefault(store.range.toDoubleRange, defaultValue: defaultVal).shouldFire(
      old, new)
  }

  @ViewBuilder
  private func StepperView(_ step: Double) -> some View {
    switch stepStyle {
      case .native:
        QuickSlider.SliderCore(value: $value, step: step)

      case .stepper:
        HStack {
          QuickSlider.SliderCore(value: $value, step: nil)

          Stepper(
            store.label.text,
            value: $value,
            step: step,
          )
          .labelsHidden()
        }

      case .none:
        QuickSlider.SliderCore(value: $value, step: nil)
    }
  }

  @ViewBuilder
  private func ContextMenuItems() -> some View {
    Button {
      copyStringToClipboard("\(value)")
    } label: {
      Label("Copy", systemImage: Icons.copy.icon)
    }

    if let sliderDefaultValue {
      Divider()
      Button {
        value = sliderDefaultValue
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
