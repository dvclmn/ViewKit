//
//  Component+Slider.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/1/2026.
//

import CoreTools
import SwiftUI

public protocol SliderFloat: BinaryFloatingPoint, Sendable, Strideable, FloatRenderable where Stride: BinaryFloatingPoint {}
extension Double: SliderFloat {}
extension CGFloat: SliderFloat {}

struct SliderTrackNativeView<Value: SliderFloat>: View  {
//struct SliderTrackNativeView<Value: BinaryFloatingPoint & Sendable & Strideable>: View {
  @Environment(SliderHandler.self) private var store
  @Environment(\.sliderStyle) private var sliderStyle

  let step: Value.Stride?
  
//  init(step: Value) where Value.Stride: BinaryFloatingPoint {
//    self.step = step
//  }
//  
//  init() {
//    self.step = nil
//  }
  
  var body: some View {

    switch sliderStyle {

      // MARK: - Native Slider
      case .native:
        @Bindable var store = store

        Group {
          if let step {
            Slider(
              value: $store.value,
              in: store.range,
              step: step.toDouble
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
        SliderCustom<Value>(style: style)

    }
  }
}

extension SliderTrackNativeView {
  private func handleOnEdit(_ didEdit: Bool) {
    let phase = SliderPhase(fromOnEditingChanged: didEdit)
    store.updatePhase(phase)
  }
}
