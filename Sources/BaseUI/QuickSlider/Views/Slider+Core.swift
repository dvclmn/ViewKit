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
  @Environment(\.sliderStyle) private var sliderStyle
  @Environment(\.explicitControlSize) private var explicitControlSize
  @Environment(\.sliderComponents) private var sliderComponents

  @Environment(\.sliderStyle) private var style
  @Environment(\.formatValue) private var formatValue
  @Environment(\.sliderDefaultValue) private var sliderDefaultValue
  @Environment(\.isDebugMode) private var isDebugMode

  @State private var isHovering: Bool = false

  public var body: some View {
    @Bindable var store = store

    // MARK: - Slider

    
    
    switch sliderStyle {
        
      // MARK: - Native Slider
      case .native:
        if sliderComponents.contains(.label) {
          LabelComponent()
          NativeSliderComponent()

        } else {
          NativeSliderComponent()
            .labelsHidden()
            .debugFrame("Native + NO Label", .orange, isEnabled: isDebugMode)
        }

      // MARK: - Custom Slider
      case .custom(let style):
        if sliderComponents.contains(.label) {
          LabelComponent()
          SliderCustom(style: style)
        } else {
          SliderCustom(style: style)
        }
    //        {
    //          if sliderComponents.contains(.label) {
    //              .debugFrame("Custom + Label", .pink, isEnabled: isDebugMode)
    //          }
    //        }

    }

    //    if sliderComponents.contains(.track) {

    //      Component_Slider()
    //            .frame(minWidth: 80)
    //        .frame(maxWidth: .infinity)
            
    //    }

    // MARK: - Units
    if sliderComponents.contains(.units) {
      //      TextColumns(alignment: .trailing) {
      Text(formatValue(store.value))
        //      }
        //      .debugFrame("Native + Units", .brown, isEnabled: isDebugMode)
        .textSelection(.disabled)
        .onDoubleTap($store.value, defaultValue: sliderDefaultValue)
    }

  }
}

extension SliderCore {

  private var columnSpan: Int { sliderComponents.count }

  private func handleHaptics(_ old: Double, _ new: Double) -> Bool {
    guard let defaultVal = sliderDefaultValue else {
      return HapticPreset.boundary(store.range).shouldFire(old, new)
    }
    return HapticPreset.boundaryAndDefault(store.range, defaultValue: defaultVal).shouldFire(old, new)
  }

  private func handleOnEdit(_ didEdit: Bool) {
    let phase = SliderPhase(fromOnEditingChanged: didEdit)
    store.updatePhase(phase)
  }

  @ViewBuilder
  func NativeSliderComponent() -> some View {
    @Bindable var store = store

    Group {
      if let step = store.step {
        Slider(
          value: $store.value,
          in: store.range,
          step: step
        ) { editing in
          handleOnEdit(editing)
        }
      } else {
        Slider(
          value: $store.value,
          in: store.range,
        ) { editing in
          handleOnEdit(editing)
        }
      }
    }
  }

  @ViewBuilder
  func LabelComponent() -> some View {
    @Bindable var store = store
    MaybeLabel(store.label)

      .onDoubleTap($store.value, defaultValue: sliderDefaultValue)
    //      .font(.body)
    //      .lineLimit(1)

    /// This can cause fuzzy text, in certain situations
    //      .fixedSize(horizontal: true, vertical: false)
  }
}
