//
//  QuickSlider.swift
//  Components
//
//  Created by Dave Coleman on 10/11/2024.
//

import CoreTools
import SwiftUI
import ViewTools

/// Receives the beginning and end of a direct slider-editing interaction.
public typealias SliderOutput = (SliderPhase) -> Void

/// A labelled numeric control that uses SwiftUI's native slider by default.
///
/// On macOS, the `trackStyle:` initialiser routes to an AppKit-backed slider
/// when a custom track is required. See <doc:QuickSlider> for the complete
/// routing model and platform behaviour.
public struct QuickSlider<SliderLabel: View>: View, ValueFormattable, SliderStylable {
  @Environment(\.isWithinSliderGroup) private var isWithinSliderGroup
  @Environment(\.sliderComponents) private var sliderComponents
  @Environment(\.helpText) private var helpText

  @State private var handler = SliderHandler()

  @Binding private var value: Double

  private let configuration: SliderConfiguration
  #if os(macOS)
  private let appKitTrack: ((SliderTrackConfiguration) -> AppKitSliderTrack)?
  #endif

  let label: SliderLabel

  public var body: some View {
    if isWithinSliderGroup {
      GridRow {

        #if os(macOS)
        SliderComponents(
          value: $value,
          configuration: configuration,
          handler: handler,
          appKitTrack: appKitTrack,
          label: label
        )
        #else
        SliderComponents(
          value: $value,
          configuration: configuration,
          handler: handler,
          label: label
        )
        #endif
      }
      HelpText()
    } else {
      HStack {
        #if os(macOS)
        SliderComponents(
          value: $value,
          configuration: configuration,
          handler: handler,
          appKitTrack: appKitTrack,
          label: label
        )
        #else
        SliderComponents(
          value: $value,
          configuration: configuration,
          handler: handler,
          label: label
        )
        #endif
        HelpText()
      }
    }
  }
}

extension QuickSlider {

  @ViewBuilder
  private func HelpText() -> some View {
    if sliderComponents.contains(.helpText), !helpText.isEmpty {
      Text(helpText)
        .font(.caption2)
        .foregroundStyle(.secondary)
    }
  }
}

// MARK: - Initialisers

extension QuickSlider where SliderLabel == EmptyView {
  /// Creates a standard native slider.
  ///
  /// On macOS and iOS 26 or later, `neutralValue` is passed to SwiftUI's
  /// native ``SwiftUI/Slider`` to identify a semantic zero point.
  public init(
    _ title: String,
    value: Binding<Double>,
    range: ClosedRange<Double>,
    step: Double? = nil,
    neutralValue: Double? = nil,
    didChangeSlider: @escaping SliderOutput = { _ in },
  ) {
    self.configuration = SliderConfiguration(
      label: LabelDescriptor(title),
      range: range,
      step: step,
      neutralValue: neutralValue,
      didChangeSlider: didChangeSlider,
    )
    self._value = value
    #if os(macOS)
    self.appKitTrack = nil
    #endif

    self.label = { EmptyView() }()
  }

  #if os(macOS)
  /// Creates a macOS slider whose track is rendered by AppKit.
  ///
  /// This is deliberately unavailable on iOS until BaseUI has a matching
  /// UIKit-backed route; it never falls back to the retired SwiftUI custom
  /// slider.
  public init<S: AppKitSliderTrackStyle>(
    _ title: String,
    value: Binding<Double>,
    range: ClosedRange<Double>,
    step: Double? = nil,
    trackStyle: S,
    didChangeSlider: @escaping SliderOutput = { _ in },
  ) {
    self.configuration = SliderConfiguration(
      label: LabelDescriptor(title),
      range: range,
      step: step,
      neutralValue: nil,
      didChangeSlider: didChangeSlider,
    )
    self._value = value
    self.appKitTrack = { configuration in
      trackStyle.makeAppKitTrack(configuration: configuration)
    }

    self.label = { EmptyView() }()
  }
  #endif

  /// Creates a discrete slider for an integer binding.
  ///
  /// An omitted step means one integer at a time. The binding rounds its
  /// double representation on write-back, preventing floating-point noise
  /// from being truncated towards zero.
  public init(
    _ title: String,
    intValue: Binding<Int>,
    range: ClosedRange<Int>,
    step: Int? = nil,
    didChangeSlider: @escaping SliderOutput = { _ in },
  ) {
    self.configuration = SliderConfiguration(
      label: LabelDescriptor(title),
      range: range.toDoubleRange,
      step: step.map(Double.init),
      neutralValue: nil,
      didChangeSlider: didChangeSlider,
    )
    self._value = intValue.toBindingDouble
    #if os(macOS)
    self.appKitTrack = nil
    #endif

    self.label = { EmptyView() }()

  }
}

extension QuickSlider {
  /// Creates a standard native slider.
  ///
  /// On macOS and iOS 26 or later, `neutralValue` is passed to SwiftUI's
  /// native ``SwiftUI/Slider`` to identify a semantic zero point.
  public init(
    value: Binding<Double>,
    range: ClosedRange<Double>,
    step: Double? = nil,
    neutralValue: Double? = nil,
    @ViewBuilder label: @escaping () -> SliderLabel,
    didChangeSlider: @escaping SliderOutput = { _ in },
  ) {
    self.configuration = SliderConfiguration(
      label: nil,
      range: range,
      step: step,
      neutralValue: neutralValue,
      didChangeSlider: didChangeSlider,
    )
    self._value = value
    #if os(macOS)
    self.appKitTrack = nil
    #endif
    self.label = label()
  }
}
