//
//  QuickSlider.swift
//  Components
//
//  Created by Dave Coleman on 10/11/2024.
//

import CoreTools
import SwiftUI
import ViewTools

public typealias SliderOutput = (SliderPhase) -> Void

public struct QuickSlider<TrackBody: View>: View, ValueFormattable, SliderStylable {
  @Environment(\.isWithinSliderGroup) private var isWithinSliderGroup
  @Environment(\.sliderComponents) private var sliderComponents
  @Environment(\.helpText) private var helpText

  public typealias Configuration = SliderTrackConfiguration
  typealias TrackBackground = (Configuration) -> TrackBody?
  #if os(macOS)
  typealias AppKitTrackBackground = (Configuration) -> AppKitSliderTrack?
  #endif

  @State private var store: SliderHandler

  @Binding var value: Double
  private let track: TrackBackground
  #if os(macOS)
  private let appKitTrack: AppKitTrackBackground?
  #endif

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
        label: LabelDescriptor(title),
        range: range.toDoubleRange,
        step: step.toDoubleIfPresent,
        characterSize: characterSize,
        didChangeSlider: didChangeSlider,
      )
    )
    self._value = value
    self.track = track
    #if os(macOS)
    self.appKitTrack = nil
    #endif
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
        #if os(macOS)
        SliderComponents(value: $value, track: track, appKitTrack: appKitTrack)
        #else
        SliderComponents(value: $value, track: track)
        #endif
      }
      HelpText()

    } else {
      HStack {
        #if os(macOS)
        SliderComponents(value: $value, track: track, appKitTrack: appKitTrack)
        #else
        SliderComponents(value: $value, track: track)
        #endif
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

  // Initialiser for a standard slider
  // TODO: Considering pivoting to SwiftUI-style
  // Label closure/ViewBuilder instead of LabelDescriptor?
  public init(
    _ title: String,
    value: Binding<Double>,
    range: ClosedRange<Double>,
    step: Double? = nil,
    characterSize: CGSize? = nil,
    didChangeSlider: @escaping SliderOutput = { _ in },
  ) where TrackBody == EmptyView {
    self._store = State(
      initialValue: SliderHandler(
        label: LabelDescriptor(title),
        range: range.toDoubleRange,
        step: step.toDoubleIfPresent,
        characterSize: characterSize,
        didChangeSlider: didChangeSlider,
      )
    )
    self._value = value
    self.track = { _ in nil }
    #if os(macOS)
    self.appKitTrack = nil
    #endif
  }

  // Initialiser for a custom track style
  public init<S: SliderTrackStyle>(
    _ title: String,
    value: Binding<Double>,
    range: ClosedRange<Double>,
    step: Double? = nil,
    characterSize: CGSize? = nil,
    trackStyle: S,
    didChangeSlider: @escaping SliderOutput = { _ in },
  ) where S.Body == TrackBody {
    self._store = State(
      initialValue: SliderHandler(
        label: LabelDescriptor(title),
        range: range.toDoubleRange,
        step: step.toDoubleIfPresent,
        characterSize: characterSize,
        didChangeSlider: didChangeSlider,
      )
    )
    self._value = value
    self.track = { configuration in
      trackStyle.makeBody(configuration: configuration)
    }

    #if os(macOS)
    if let appKitStyle = trackStyle as? any AppKitSliderTrackStyle {
      self.appKitTrack = { configuration in
        appKitStyle.makeAppKitTrack(configuration: configuration)
      }
    } else {
      self.appKitTrack = nil
    }
    #endif
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

    self._store = State(
      initialValue: SliderHandler(
        label: LabelDescriptor(title),
        range: range.toDoubleRange,
        step: step.toDoubleIfPresent,
        characterSize: characterSize,
        didChangeSlider: didChangeSlider,
      )
    )
    self._value = intValue.toBindingDouble
    self.track = { _ in nil }
#if os(macOS)
    self.appKitTrack = nil
#endif
//    self.init(
//      title,
//      value: intValue.toBindingDouble,
//      range: range.toDoubleRange,
//      step: step?.toDouble,
//      characterSize: characterSize,
//      track: { _ in },
//      didChangeSlider: didChangeSlider,
//    )
  }
}
