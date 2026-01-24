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
  @Environment(\.sliderComponents) private var sliderComponents
  @State private var store: SliderHandler

  @Binding var value: Double

  public var body: some View {

    Group {
      if isWithinSliderGroup {
        GridRow {
          /// Handles slider Label, Track, and Units display
          SliderCore()
        }

      } else {
        HStack {
          SliderCore()
        }
      }
    }
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
    step: Double? = nil,
    didChangeSlider: @escaping SliderOutput = { _ in },
  ) {
    self.init(
      label: QuickLabel(title),
      value: value,
      range: range,
      step: step,
      didChangeSlider: didChangeSlider
    )
  }

  public init(
    label: QuickLabel,
    value: Binding<Double>,
    range: ClosedRange<Double>,
    step: Double? = nil,
    didChangeSlider: @escaping SliderOutput = { _ in },
  ) {
    self._value = value
    self._store = State(
      initialValue: SliderHandler(
        value: value.wrappedValue,
        label: label,
        range: range,
        step: step,
        didChangeSlider: didChangeSlider
      )
    )
  }
}
