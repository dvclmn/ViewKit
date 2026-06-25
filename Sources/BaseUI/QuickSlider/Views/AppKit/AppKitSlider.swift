//
//  AppKitSlider.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/6/2026.
//

#if os(macOS)
import AppKit
import SwiftUI

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
    }

    slider.needsDisplay = true
  }
}

extension AppKitSlider {
  @MainActor
  final class Coordinator: NSObject {
    var value: Binding<Double>
    var range: ClosedRange<Double>
    var step: Double?
    var onEditingChanged: (Bool) -> Void

    private var isEditing = false

    init(
      value: Binding<Double>,
      range: ClosedRange<Double>,
      step: Double?,
      onEditingChanged: @escaping (Bool) -> Void,
    ) {
      self.value = value
      self.range = range
      self.step = step
      self.onEditingChanged = onEditingChanged
    }

    @objc func valueChanged(_ slider: NSSlider) {
      let newValue = snapped(slider.doubleValue)

      if !newValue.isApproximatelyEqual(to: slider.doubleValue) {
        slider.doubleValue = newValue
      }

      if !newValue.isApproximatelyEqual(to: value.wrappedValue) {
        value.wrappedValue = newValue
      }
    }

    func setEditing(_ editing: Bool) {
      guard editing != isEditing else { return }

      isEditing = editing
      onEditingChanged(editing)
    }

    func snapped(_ value: Double) -> Double {
      let clamped = min(max(value, range.lowerBound), range.upperBound)

      guard let step, step > 0 else {
        return clamped
      }

      let offset = (clamped - range.lowerBound) / step
      let stepped = range.lowerBound + (offset.rounded() * step)

      return min(max(stepped, range.lowerBound), range.upperBound)
    }
  }
}

final class TrackingSlider: NSSlider {
  var onEditingChanged: ((Bool) -> Void)?

  override func mouseDown(with event: NSEvent) {
    onEditingChanged?(true)
    defer { onEditingChanged?(false) }
    super.mouseDown(with: event)
  }

  override func keyDown(with event: NSEvent) {
    onEditingChanged?(true)
    defer { onEditingChanged?(false) }
    super.keyDown(with: event)
  }
}



extension ControlSize {
  fileprivate var nsControlSize: NSControl.ControlSize {
    switch self {
      case .mini: .mini
      case .small: .small
      case .regular: .regular
      case .large: .large
      case .extraLarge: .large
      @unknown default: .regular
    }
  }
}

extension Double {
  fileprivate func isApproximatelyEqual(to other: Double) -> Bool {
    abs(self - other) <= .ulpOfOne
  }
}
#endif
