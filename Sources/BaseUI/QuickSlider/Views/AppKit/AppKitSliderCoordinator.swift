//
//  AppKitSliderCoordinator.swift
//  ViewKit
//
//  Created by Dave Coleman on 25/6/2026.
//

#if os(macOS)
import SwiftUI

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
//      if !appKitSliderValuesAreEqual(newValue, slider.doubleValue) {
        slider.doubleValue = newValue
      }

      if !newValue.isApproximatelyEqual(to: value.wrappedValue) {
//      if !appKitSliderValuesAreEqual(newValue, value.wrappedValue) {
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

#endif
