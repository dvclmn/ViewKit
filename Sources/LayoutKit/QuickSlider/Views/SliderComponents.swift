//
//  Slider+Unified.swift
//  BaseComponents
//
//  Created by Dave Coleman on 11/8/2025.
//

import BasePrimitives
import SwiftUI

extension QuickSlider {
  struct SliderComponents: View {
    @Environment(SliderHandler.self) private var store
    @Environment(\.sliderComponents) private var sliderComponents
    @Environment(\.sliderTrackMaxWidth) private var sliderTrackMaxWidth
    @Environment(\.formatValue) private var formatValue
    @Environment(\.sliderDefaultValue) private var sliderDefaultValue
    @Environment(\.isDebugMode) private var isDebugMode

    @State private var isHovering: Bool = false

    @Binding var value: Double
    let track: TrackBackground

    var body: some View {
      @Bindable var store = store

      // MARK: - Label
      if sliderComponents.contains(.label) {
        SliderLabel(value: $value)
      }

      // MARK: - Main Track
      SliderCore(value: $value, track: track)

        .frame(width: sliderTrackMaxWidth)
        .frame(maxWidth: .infinity, alignment: .trailing)

      // MARK: - Units
      if sliderComponents.contains(.units) {
        TextColumns(alignment: .trailing) {
          Text(formatValue.format(value.toDouble, store.range))
        }
        .textSelection(.disabled)
        .onDoubleTap($value, defaultValue: sliderDefaultValue)
        .contextMenu { ContextMenuItems() }
      }
    }
  }
}

extension QuickSlider.SliderComponents {

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
      Label("Copy Value", systemImage: Icons.copy.icon)
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

}
