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
    GridRow {
      HStack {
        // MARK: - Slider
        if sliderComponents.contains(.slider) {

          Component_Slider()
            .frame(minWidth: 80)
            .sensoryFeedback(.alignment, trigger: store.value) {
              oldValue,
              newValue in

              HapticPreset.boundaryReached.hapticPreset(
                for: store.range.toDoubleRange,
                with: sliderDefaultValue,
                oldValue,
                newValue
              )
            }
            .controlSize(explicitControlSize ?? .regular)
        }

        // MARK: - Units
        if sliderComponents.contains(.units) {
          TextColumns {
            Text(formatValue(store.value))
          }
          .textSelection(.disabled)
          .onDoubleTap($store.value, defaultValue: sliderDefaultValue)
        }
      }
    }  // END grid row

  }
}

extension SliderCore {

}
