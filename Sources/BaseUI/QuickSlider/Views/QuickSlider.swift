//
//  QuickSlider.swift
//  Components
//
//  Created by Dave Coleman on 10/11/2024.
//

import BasePrimitives
import SwiftUI

public typealias SliderOutput = (SliderPhase) -> Void

public struct QuickSlider<TrackBody: View>: View, ValueFormattable, SliderStylable {
  @Environment(\.isWithinSliderGroup) private var isWithinSliderGroup
  @Environment(\.sliderComponents) private var sliderComponents
  @Environment(\.helpText) private var helpText

  public typealias Configuration = SliderTrackConfiguration
  typealias TrackBackground = (Configuration) -> TrackBody?

  @State private var store: SliderHandler

  @Binding var value: Double
  private let track: TrackBackground

  public init(
    _ title: String,
    value: Binding<Double>,
    range: ClosedRange<Double>,
    step: Double? = nil,
    characterSize: CGSize? = nil,
    @ViewBuilder track: @escaping (Configuration) -> TrackBody?,
    didChangeSlider: @escaping SliderOutput = { _ in },
  ) {

    self._store = State(
      initialValue: SliderHandler(
        label: QuickLabel(title),
        range: range.toDoubleRange,
        step: step.toDoubleIfPresent,
        characterSize: characterSize,
        didChangeSlider: didChangeSlider,
      )
    )
    self._value = value
    self.track = track
  }

  public var body: some View {

    SliderContentView()
      .environment(store)
  }
}
extension QuickSlider {

  @ViewBuilder
  private func SliderContentView() -> some View {
    if isWithinSliderGroup {
      /// This is super useful, allowing nicely-aligned labels and tracks
      /// for neighbouring Sliders. As long as they're within a SliderGroup
      GridRow {
        /// Handles slider Label, Track, and Units display
        SliderComponents(value: $value, track: track)
      }
      HelpText()

    } else {
      HStack {
        SliderComponents(value: $value, track: track)
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

  // TODO: Considering pivoting to SwiftUI-style
  // Label closure/ViewBuilder instead of QuickLabel?
  public init(
    _ title: String,
    value: Binding<Double>,
    range: ClosedRange<Double>,
    step: Double? = nil,
    characterSize: CGSize? = nil,
    didChangeSlider: @escaping SliderOutput = { _ in },
  ) where TrackBody == EmptyView {
    self._value = value
    self._store = State(
      initialValue: SliderHandler(
        label: QuickLabel(title),
        range: range.toDoubleRange,
        step: step.toDoubleIfPresent,
        characterSize: characterSize,
        didChangeSlider: didChangeSlider,
      )
    )
    self.track = { _ in nil }
  }

}
extension QuickSlider {

  public init<S: SliderTrackStyle>(
    _ title: String,
    value: Binding<Double>,
    range: ClosedRange<Double>,
    step: Double? = nil,
    characterSize: CGSize? = nil,
    trackStyle: S,
    didChangeSlider: @escaping SliderOutput = { _ in },
  ) where S.Body == TrackBody {
    self.init(
      title,
      value: value,
      range: range,
      step: step,
      characterSize: characterSize,
      track: { configuration in
        trackStyle.makeBody(configuration: configuration)
      },
      didChangeSlider: didChangeSlider,
    )
  }

  /// For Binding to Int more conveniently
  public init(
    _ title: String,
    intValue: Binding<Int>,
    range: ClosedRange<Int>,
    step: Int? = nil,
    characterSize: CGSize? = nil,
    didChangeSlider: @escaping SliderOutput = { _ in },
  ) where TrackBody == EmptyView {

    self.init(
      title,
      value: intValue.toBindingDouble,
      range: range.toDoubleRange,
      step: step?.toDouble,
      characterSize: characterSize,
      track: { _ in },
      didChangeSlider: didChangeSlider,
    )
  }
}
