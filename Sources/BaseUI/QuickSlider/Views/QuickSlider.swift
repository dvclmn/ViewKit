//
//  QuickSlider.swift
//  Components
//
//  Created by Dave Coleman on 10/11/2024.
//

import CoreTools
import SwiftUI

public typealias SliderOutput = (SliderPhase) -> Void

public struct QuickSlider<Value: SliderFloat>: View, ValueFormattable, SliderStylable {
  @Environment(\.isWithinSliderGroup) private var isWithinSliderGroup
  @Environment(\.sliderComponents) private var sliderComponents
  @State private var store: SliderHandler<Value>

  @Binding var value: Value

  public var body: some View {

    Group {
      if isWithinSliderGroup {
        GridRow {
          /// Handles slider Label, Track, and Units display
          SliderCore<Value>()
        }

      } else {
        HStack {
          SliderCore<Value>()
        }
      }
    }
    .environment(store)
    .bindModel($store.value, to: $value)
  }
}

// MARK: - Initialisers
extension QuickSlider {

  public init(
    _ title: String,
    value: Binding<Value>,
    range: ClosedRange<Value>,
    step: Value.Stride? = nil,
    didChangeSlider: @escaping SliderOutput = { _ in },
  ) where Value.Stride: BinaryFloatingPoint {
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
    value: Binding<Value>,
    range: ClosedRange<Value>,
    step: Value.Stride? = nil,
    didChangeSlider: @escaping SliderOutput = { _ in },
  ) {
    self._value = value
    self._store = State(
      initialValue: SliderHandler(
        value: value.wrappedValue,
        label: label,
        range: range,
        step: step,
//        step: step.map { Double($0) },
        //        step: StepStyle(fromOptionalValue: step.map { Double($0) }),
        didChangeSlider: didChangeSlider
      )
    )
  }

  /// For Binding to Int more conveniently
  public init(
    _ title: String,
    intValue: Binding<Int>,
    range: ClosedRange<Int>,
    step: Int? = nil,
    didChangeSlider: @escaping SliderOutput = { _ in },
  ) where Value == Double {
    self.init(
      label: QuickLabel(title),
      value: intValue.toBindingDouble,
      range: range.toDoubleRange,
      step: step?.toDouble,
      didChangeSlider: didChangeSlider
    )
  }

  //  public init(
  //    _ title: String,
  //    value: Binding<Double>,
  //    range: ClosedRange<Double>,
  //    step: Double? = nil,
  //    didChangeSlider: @escaping SliderOutput = { _ in },
  //  ) {
  //    self.init(
  //      label: QuickLabel(title),
  //      value: value,
  //      range: range,
  //      step: step,
  //      didChangeSlider: didChangeSlider
  //    )
  //  }
}
