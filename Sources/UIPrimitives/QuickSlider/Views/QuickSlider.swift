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
  @Environment(\.helpText) private var helpText

  @State private var store: SliderHandler

  @Binding var value: Double

  public var body: some View {

    SliderContentView()
      .environment(store)
  }
}
extension QuickSlider {

  @ViewBuilder
  private func SliderContentView() -> some View {
    if isWithinSliderGroup {
      GridRow {
        /// Handles slider Label, Track, and Units display
        SliderComponents(value: $value)
      }
      HelpText()

    } else {
      HStack {
        SliderComponents(value: $value)
        HelpText()
      }
    }
  }

  @ViewBuilder
  private func HelpText() -> some View {
    if !helpText.isEmpty {
      Text(helpText)
        .font(.caption2)
        .foregroundStyle(.secondary)
    }

  }
}
// MARK: - Initialisers
extension QuickSlider {

  public init(
    _ title: LocalizedStringKey,
    value: Binding<Double>,
    range: ClosedRange<Double>,
    step: Double? = nil,
    minMaxLabels: (String, String)? = nil,
    didChangeSlider: @escaping SliderOutput = { _ in },
  ) {
    self.init(
      label: QuickLabel(title),
      value: value,
      range: range,
      step: step,
      minMaxLabels: minMaxLabels,
      didChangeSlider: didChangeSlider
    )
  }

  // TODO: Considering pivoting to SwiftUI-style
  // Label closure/ViewBuilder instead of QuickLabel?
  public init(
    label: QuickLabel,
    value: Binding<Double>,
    range: ClosedRange<Double>,
    step: Double? = nil,
    minMaxLabels: (String, String)? = nil,
    didChangeSlider: @escaping SliderOutput = { _ in },
  ) {
    self._value = value
    self._store = State(
      initialValue: SliderHandler(
        label: label,
        range: range.toDoubleRange,
        step: step.toDoubleIfPresent,
        minMaxLabels: minMaxLabels,
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
  ) {
    self.init(
      label: QuickLabel(title),
      value: intValue.toBindingDouble,
      range: range.toDoubleRange,
      step: step?.toDouble,
      didChangeSlider: didChangeSlider
    )
  }
}
