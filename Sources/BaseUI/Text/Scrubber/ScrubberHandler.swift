//
//  ScrubberHandler.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/1/2026.
//

import CoreTools
import SwiftUI

@Observable
final class ScrubberHandler {
  var value: Double = .zero
  var range: ClosedRange<Double>?
  var initialValue: CGFloat

  var isHovered: Bool = false

  init(initialValue: CGFloat) {
    self.initialValue = initialValue
  }
}

extension ScrubberHandler {

  func stepSize(modifiers: Modifiers) -> CGFloat {
    let increments = NumericIncrements.standard
    return increments.stepSize(for: modifiers)
  }

  func valueString(places: Int?) -> String {
    valueClamped.displayString(places: places ?? 0)
  }
  var valueClamped: Double {
    guard let range else { return value }
    return value.clamped(to: range)
  }

  func updateValue(
    _ direction: Direction,
    modifiers: Modifiers
  ) {
    let delta = stepSize(modifiers: modifiers)

    let val = direction.apply(to: value, by: delta).clampedIfNeeded(to: range)

    self.value = val
  }

  //  var valueClampedBinding: Binding<Double> {
  //    value.clampedIfNeeded(to: range)
  //  }

  func handleKeyPress(
    _ direction: Direction,
    modifiers: Modifiers
  ) -> KeyPress.Result {
    guard direction.isVertical else { return .ignored }
    updateValue(direction, modifiers: modifiers)
    return .handled
  }

}
