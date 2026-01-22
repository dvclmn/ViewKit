//
//  Slider+Unified.swift
//  BaseComponents
//
//  Created by Dave Coleman on 11/8/2025.
//

import BasePrimitives
import SwiftUI

public struct SliderCore: View {
  @Environment(\.sliderHandler) private var store

  @Environment(\.explicitControlSize) private var explicitControlSize
  @Environment(\.sliderComponents) private var sliderComponents

  @Environment(\.sliderStyle) private var style
  @Environment(\.formatValue) private var formatValue
  @Environment(\.sliderDefaultValue) private var sliderDefaultValue

  @State private var isHovering: Bool = false

  public var body: some View {
    @Bindable var store = store

    // MARK: - Slider
    if sliderComponents.contains(.slider) {

      Component_Slider()
        //            .frame(minWidth: 80)
        .frame(maxWidth: .infinity)
        .sensoryFeedback(.alignment, trigger: store.value) {
          handleHaptics($0, $1)
        }
        .controlSize(explicitControlSize ?? .regular)
    }

    // MARK: - Units
    if sliderComponents.contains(.units) {
      TextColumns(alignment: .trailing) {
        Text(formatValue(store.value))
      }
      .textSelection(.disabled)
      .onDoubleTap($store.value, defaultValue: sliderDefaultValue)
    }

    
  }
}

extension SliderCore {
  private func handleHaptics(_ old: Double, _ new: Double) -> Bool {
    guard let defaultVal = sliderDefaultValue else {
      return HapticPreset.boundary(store.range).shouldFire(old, new)
    }
    return HapticPreset.boundaryAndDefault(store.range, defaultValue: defaultVal).shouldFire(old, new)

  }
}
