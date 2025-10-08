//
//  Slider+RegularSize.swift
//  BaseComponents
//
//  Created by Dave Coleman on 14/5/2025.
//

import SwiftUI

//public struct SliderNative: View {
////  @Environment(\.sliderControlSize) private var controlSize
////  @Environment(\.sliderComponents) private var sliderComponents
////
////  @Environment(\.sliderRange) private var range
////  @Environment(\.sliderLabel) private var label
////  @Environment(\.sliderDefaultValue) private var defaultValue
////  let bottomPadding: CGFloat = 8
//
//  @Binding var value: Double
//  @Binding var store: SliderHandler
//
//  public var body: some View {
//
//    GridRow {
//      HStack {
//
//        if sliderComponents.contains(.slider) {
//
//          Group {
//            if sliderComponents.contains(.label) {
//              SliderComponent()
//            } else {
//              SliderComponent()
//                .labelsHidden()
//            }
//          }
//          .sensoryFeedback(.alignment, trigger: value) {
//            oldValue,
//            newValue in
//
//            HapticPreset.boundaryReached.hapticPreset(
//              for: range,
//              with: defaultValue,
//              oldValue,
//              newValue
//            )
//          }
//          .controlSize(controlSize)
//        }
//
//        if sliderComponents.contains(.units) {
//          TextColumns {
//            if let formatted = store.formatValue?(value) {
//              Text(formatted)
//            } else {
//              Text(value.displayString)
//            }
//          }
//          .onDoubleTap($value, defaultValue: defaultValue)
//        }
//      }
//    }  // END grid row
//
//  }
//}
//
//extension SliderNative {
//
//  @ViewBuilder
//  func SliderComponent() -> some View {
//    Slider(
//      value: $value,
//      in: range
//    ) {
//      MaybeLabel(label)
//        .onDoubleTap($value, defaultValue: defaultValue)
//
//    } onEditingChanged: { editing in
//      let phase = SliderPhase(fromOnEditingChanged: editing)
//      store.phase = phase
//      store.triggerDidChangeSlider(phase)
//    }
//  }
//
//}
