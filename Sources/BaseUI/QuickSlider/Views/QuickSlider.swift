//
//  QuickSlider.swift
//  Components
//
//  Created by Dave Coleman on 10/11/2024.
//

import CoreTools
import SwiftUI

public typealias SliderOutput = (SliderPhase) -> Void

public struct QuickSlider: View, ValueFormattable, SliderStylable {
  @Environment(\.isWithinSliderGroup) private var isWithinSliderGroup
  @State private var store: SliderHandler

  @Binding var value: Double
  let label: QuickLabel
  let range: ClosedRange<Double>
  let didChangeSlider: SliderOutput

  public var body: some View {

    /// Handles slider Label, Track, and Units display

    Group {
      if isWithinSliderGroup {
        GridRow {
          SliderCore()
        }

      } else {
        HStack {
          SliderCore()
        }
      }
    }
    .onAppear {
      if store.didChangeSlider == nil {
        store.didChangeSlider = didChangeSlider
      }
    }
    .task(id: label) { store.label = label }
    .task(id: range) { store.range = range }
    .bindModel($store.value, to: $value)
    .environment(\.sliderHandler, store)
  }
}

// MARK: - Initialisers
extension QuickSlider {
  public init(
    _ title: String,
    value: Binding<Double>,
    range: ClosedRange<Double>,
    didChangeSlider: @escaping SliderOutput = { _ in },
  ) {
    self.init(
      label: QuickLabel(title),
      value: value,
      range: range,
      didChangeSlider: didChangeSlider
    )
  }

  public init(
    label: QuickLabel,
    value: Binding<Double>,
    range: ClosedRange<Double>,
    didChangeSlider: @escaping SliderOutput = { _ in },
  ) {
    self.label = label
    self._value = value
    self.range = range
    self._store = State(
      initialValue: SliderHandler(
        value: value.wrappedValue,
        label: label,
        range: range
      )
    )
    self.didChangeSlider = didChangeSlider
  }
}
