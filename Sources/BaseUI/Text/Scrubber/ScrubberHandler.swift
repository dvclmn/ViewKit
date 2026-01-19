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
  var title: String = ""
  var value: Double = .zero
  var range: ClosedRange<Double>?
  var strategy: ScrubStrategy = .continuous

  var isDragging: Bool = false

  /// For gesture state
  var initialValue: Double

  var isHovered: Bool = false

  init(
    initialValue: Double
  ) {
    self.initialValue = initialValue
  }
}

extension ScrubberHandler {

  /// This returns a 1/10/100 increment based on modifiers,
  /// unless a specific `stepped` Strategy is selected
  func stepSize(modifiers: Modifiers) -> Double {
    strategy.stepSize(with: modifiers)
  }

  func valueString(places: Int?) -> String {
    valueClamped.displayString(places: places ?? 0)
  }
  var valueClamped: Double {
    guard let range else { return value }
    return value.clamped(to: range)
  }

  //  func updateValue(
  //    _ direction: Direction,
  //    modifiers: Modifiers
  //  ) {
  //
  //  }

  //  var valueClampedBinding: Binding<Double> {
  //    value.clampedIfNeeded(to: range)
  //  }

  func handleKeyPress(
    key: KeyEquivalent,
    //    _ direction: Direction,
    modifiers: Modifiers
  ) -> KeyPress.Result {

    guard let direction = key.toDirection,
      direction.isVertical
    else { return .ignored }

    let delta = stepSize(modifiers: modifiers)
    
    guard let val = key.apply(delta, to: value) else {
      return .ignored
    }

    guard let range else {
      self.value = val
      return .handled
    }
    guard range.contains(val) else {
      return .ignored
    }
    self.value = val.clamped(to: range)
    return .handled
  }
}

extension KeyEquivalent {

  func apply(_ delta: Double, to value: Double) -> Double? {
    switch self {
      case .upArrow: value + delta
      case .downArrow: value - delta
      default: nil
    }
  }

  var toDirection: Direction? {
    switch self {
      case .upArrow: .up
      case .downArrow: .down
      default: nil
    }
  }
}
