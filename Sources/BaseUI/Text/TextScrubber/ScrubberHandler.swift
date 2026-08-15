//
//  ScrubberHandler.swift
//  ViewKit
//
//  Created by Dave Coleman on 18/1/2026.
//

import CoreTools
import ViewTools
//import InteractionKit
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

  var isHovering: Bool = false

  init(
    initialValue: Double
  ) {
    self.initialValue = initialValue
  }
}

extension ScrubberHandler {

  var dragRangePhase: RangePhase {
    RangePhase.phase(value: value, range: range, isDragging: isDragging)
  }
  
  func isDragReady(_ isDebugMode: Bool, modifiers: Modifiers) -> Bool {
    (isPreview && isDebugMode) || modifiers.isHoldingOption
  }

  /// This returns a 1/10/100 increment based on modifiers,
  /// unless a specific `stepped` Strategy is selected
  func stepSize(modifiers: Modifiers) -> Double {
    strategy.stepSize(with: modifiers)
  }

  func valueString(places: Int?) -> String {
    valueClampedIfNeeded.displayString(.wholeNumber)
  }
  var valueClampedIfNeeded: Double {
    guard let range else { return value }
    return value.clamped(to: range)
  }
  
  func handleKeyPress(
    key: KeyEquivalent,
    modifiers: Modifiers
  ) -> KeyPress.Result {
    
    let delta = stepSize(modifiers: modifiers)
    
    guard let newValue = key.applying(delta, to: value) else {
      return .ignored
    }
    
    value = range.map { newValue.clamped(to: $0) } ?? newValue
    return .handled
  }

  
//  func handleKeyPress(
//    key: KeyEquivalent,
//    modifiers: Modifiers
//  ) -> KeyPress.Result {
//
//    let delta = stepSize(modifiers: modifiers)
//
//    guard let val = key.apply(delta, to: value) else {
//      return .ignored
//    }
//
//    guard let range else {
//      self.value = val
//      return .handled
//    }
//    guard range.contains(val) else {
//      return .ignored
//    }
//    self.value = val.clamped(to: range)
//    return .handled
//  }
}

extension KeyEquivalent {

  func applying(_ delta: Double, to value: Double) -> Double? {
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
