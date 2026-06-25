//
//  AppKitSlider.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/6/2026.
//

#if os(macOS)
import AppKit
import SwiftUI
import CoreTools

struct AppKitSlider: NSViewRepresentable {
  @Environment(\.controlSize) private var controlSize

  @Binding var value: Double

  var range: ClosedRange<Double>
  var step: Double?
  var track: AppKitSliderTrack
  var drawsTrack: Bool
  var drawsThumb: Bool
  var isEnabled: Bool
  var accessibilityLabel: String
  var onEditingChanged: (Bool) -> Void

  func makeCoordinator() -> Coordinator {
    Coordinator(
      value: $value,
      range: range,
      step: step,
      onEditingChanged: onEditingChanged,
    )
  }

  func makeNSView(context: Context) -> TrackingSlider {
    let slider = TrackingSlider(frame: .zero)
    slider.cell = AppKitSliderCell()
    slider.target = context.coordinator
    slider.action = #selector(Coordinator.valueChanged(_:))
    slider.isContinuous = true
    slider.sliderType = .linear
    slider.wantsLayer = true
    slider.onEditingChanged = context.coordinator.setEditing(_:)

    return slider
  }

  func updateNSView(_ slider: TrackingSlider, context: Context) {
    context.coordinator.value = $value
    context.coordinator.range = range
    context.coordinator.step = step
    context.coordinator.onEditingChanged = onEditingChanged

    slider.minValue = range.lowerBound
    slider.maxValue = range.upperBound
    slider.isEnabled = isEnabled
    slider.controlSize = controlSize.nsControlSize
    slider.setAccessibilityLabel(accessibilityLabel)

    let snappedValue = context.coordinator.snapped(value)
    if !snappedValue.isApproximatelyEqual(to: slider.doubleValue) {
      slider.doubleValue = snappedValue
    }

    if let cell = slider.cell as? AppKitSliderCell {
      cell.track = track
      cell.drawsTrack = drawsTrack
      cell.drawsThumb = drawsThumb
      cell.horizontalVisualOverflow = Self.pressedKnobVisualOverflow
    }

    slider.needsDisplay = true
  }
}

extension AppKitSlider {
  /// Native Tahoe sliders draw the pressed knob outside its idle rect.
  /// SwiftUI Previews clip AppKit representables tightly, so the view is
  /// given a matching invisible margin in `SliderCore`.
  static let pressedKnobVisualOverflow: CGFloat = 6
}

#endif
