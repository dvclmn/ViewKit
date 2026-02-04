//
//  Component+Slider.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/1/2026.
//

import CoreTools
import SwiftUI

struct SliderTrackView: View {
  @Environment(SliderHandler.self) private var store
  @Environment(\.sliderStyle) private var sliderStyle

  var body: some View {

    switch sliderStyle {

      // MARK: - Native Slider
      case .native:
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
        .labelsHidden()

      // MARK: - Custom Slider
      case .custom(let style):
        SliderCustom(style: style)

    }
  }
}

extension SliderTrackView {
  private func handleOnEdit(_ didEdit: Bool) {
    let phase = SliderPhase(fromOnEditingChanged: didEdit)
    store.updatePhase(phase)
  }
}

//struct Component_Slider: View {
//
//  @Environment(\.sliderComponents) private var sliderComponents
//  @Environment(\.sliderHandler) private var store
//  @Environment(\.sliderDefaultValue) private var sliderDefaultValue
//  @Environment(\.isDebugMode) private var isDebugMode
//
//  var body: some View {
//    @Bindable var store = store
//
//    switch sliderStyle {
//      // MARK: - Native Slider
//      case .native:
//        if sliderComponents.contains(.label) {
//          LabelComponent()
//          NativeSliderComponent()
//            .debugFrame("Native + Label", .green, isEnabled: isDebugMode)
//
//        } else {
//          NativeSliderComponent()
//            .labelsHidden()
//            .debugFrame("Native + NO Label", .orange, isEnabled: isDebugMode)
//        }
//
//      // MARK: - Custom Slider
//      case .custom(let style):
//        SliderCustom(style: style) {
//          if sliderComponents.contains(.label) {
//            LabelComponent()
//              .debugFrame("Custom + Label", .pink, isEnabled: isDebugMode)
//          }
//        }
//
//    }
//  }
//}

//extension Component_Slider {

//  private func handleOnEdit(_ didEdit: Bool) {
//    let phase = SliderPhase(fromOnEditingChanged: didEdit)
//    store.updatePhase(phase)
//  }
//
//  @ViewBuilder
//  func NativeSliderComponent() -> some View {
//    @Bindable var store = store
//
//    Group {
//      if let step = store.step {
//        Slider(
//          value: $store.value,
//          in: store.range,
//          step: step
//        ) { editing in
//          handleOnEdit(editing)
//        }
//      } else {
//        Slider(
//          value: $store.value,
//          in: store.range,
//        ) { editing in
//          handleOnEdit(editing)
//        }
//      }
//    }
////    .frame(maxWidth: .infinity)
//
//  }
//
//  @ViewBuilder
//  func LabelComponent() -> some View {
//    @Bindable var store = store
//    MaybeLabel(store.label)
//    //      .onDoubleTap($store.value, defaultValue: sliderDefaultValue)
//    //      .font(.body)
//    //      .lineLimit(1)
//
//    /// This can cause fuzzy text, in certain situations
//    //      .fixedSize(horizontal: true, vertical: false)
//  }
//}
