//
//  AppKitSlider.swift
//  ViewKit
//
//  Created by Dave Coleman on 25/6/2026.
//

#if os(macOS)
import AppKit
import CoreTools
import SwiftUI

/// SwiftUI's bridge to the AppKit slider used for custom macOS tracks.
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

    var needsDisplay = false

    if slider.minValue != range.lowerBound {
      slider.minValue = range.lowerBound
      needsDisplay = true
    }
    if slider.maxValue != range.upperBound {
      slider.maxValue = range.upperBound
      needsDisplay = true
    }
    if slider.isEnabled != isEnabled {
      slider.isEnabled = isEnabled
      needsDisplay = true
    }
    if slider.controlSize != controlSize.nsControlSize {
      slider.controlSize = controlSize.nsControlSize
      needsDisplay = true
    }
    slider.setAccessibilityLabel(accessibilityLabel)

    let snappedValue = context.coordinator.snapped(value)
    if !snappedValue.isApproximatelyEqual(to: slider.doubleValue) {
      slider.doubleValue = snappedValue
      needsDisplay = true
    }

    if let cell = slider.cell as? AppKitSliderCell {
      if cell.track != track {
        cell.track = track
        needsDisplay = true
      }
      if cell.drawsTrack != drawsTrack {
        cell.drawsTrack = drawsTrack
        needsDisplay = true
      }
      if cell.drawsThumb != drawsThumb {
        cell.drawsThumb = drawsThumb
        needsDisplay = true
      }
      if cell.horizontalVisualOverflow != Self.pressedKnobVisualOverflow {
        cell.horizontalVisualOverflow = Self.pressedKnobVisualOverflow
        needsDisplay = true
      }
    }

    if needsDisplay {
      slider.needsDisplay = true
    }
  }
}

extension AppKitSlider {
  /// Native Tahoe sliders draw the pressed knob outside its idle rect.
  /// SwiftUI Previews clip AppKit representables tightly, so the view is
  /// given a matching invisible margin in `SliderCore`.
  static let pressedKnobVisualOverflow: CGFloat = 6

  /// Retains the prior custom control's generous vertical hit area while
  /// allowing AppKit to draw and track the slider itself.
  static let controlHeight: CGFloat = 21
}

#endif
