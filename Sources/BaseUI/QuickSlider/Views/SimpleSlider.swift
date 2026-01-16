//
//  QuickSlider.swift
//  Components
//
//  Created by Dave Coleman on 10/11/2024.
//

import BasePrimitives
import SwiftUI

public typealias SliderOutput = (SliderPhase) -> Void

public struct QuickSlider: View, EnvironmentFormattable {
  @Environment(\.sliderControlSize) private var sliderControlSize
  @Environment(\.formatValue) private var formatValue

  @State private var store: SliderHandler
  @Binding var value: Double
  let type: SliderType
  let didChangeSlider: SliderOutput

  public init(
    _ title: String,
    value: Binding<Double>,
    range: ClosedRange<Double>,
    type: SliderType = .native,
    didChangeSlider: @escaping SliderOutput = { _ in },
  ) {
    self.init(
      label: QuickLabel(title),
      value: value,
      range: range,
      type: type,
      didChangeSlider: didChangeSlider
    )
  }

  public init(
    label: QuickLabel,
    value: Binding<Double>,
    range: ClosedRange<Double>,
    type: SliderType = .native,
    didChangeSlider: @escaping SliderOutput = { _ in },
  ) {

    /// Get handler started with the slider `range`
    self._store = State(
      initialValue: SliderHandler(
        range: range.toCGFloatRange,
        label: label,
      )
    )
    self._value = value
    self.type = type
    self.didChangeSlider = didChangeSlider

  }

  public var body: some View {
    /// No longer based on Compact mode, but whether a track view is passed
    SliderUnified(
      value: $value,
      store: $store,
      type: type
    )
    .environment(\.sliderLabel, store.label)
    .environment(\.sliderRange, store.range.toDoubleRange)

    .onAppear {
      if store.didChangeSlider == nil {
        store.didChangeSlider = didChangeSlider
      }

      if store.formatValue == nil {
        store.formatValue = formatValue
      }
    }
  }
}
