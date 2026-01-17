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

  @Environment(\.sliderControlSize) private var controlSize
  @Environment(\.sliderComponents) private var sliderComponents

  @Environment(\.sliderRange) private var range
  @Environment(\.sliderLabel) private var label
  @Environment(\.formatValue) private var formatValue
  @Environment(\.sliderDefaultValue) private var defaultValue

  @Environment(\.explicitHeight) private var explicitHeight
  @Environment(\.cornerRounding) private var cornerRounding

  @State private var isHovering: Bool = false

//  @Binding var value: Double

  let type: SliderStyle

  public var body: some View {
    @Bindable var store = store
    GridRow {
      HStack {
        // MARK: - Slider
        if sliderComponents.contains(.slider) {

          Component_Slider(style: type)
            .frame(minWidth: 80)
            .sensoryFeedback(.alignment, trigger: store.value) {
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
          TextColumns {
            
            Text(formatValue(store.value))
//            if let formatted =  {
//            if let formatted = store.formatValue?(value) {
//              Text(formatted)
//            } else {
//              Text(store.value.displayString)
//            }
          }
          .textSelection(.disabled)
          .onDoubleTap($store.value, defaultValue: defaultValue)

        }
      }
    }  // END grid row

  }
}

extension SliderCore {

}
