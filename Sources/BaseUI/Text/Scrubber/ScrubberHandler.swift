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

  var valueClamped: Double {
    guard let range else { return value }
    return value.clamped(to: range)
  }
  
//  var valueClampedBinding: Binding<Double> {
//    value.clampedIfNeeded(to: range)
//  }

  func updateValue(_ direction: Direction) -> KeyPress.Result {

    switch direction {
      case .up:
        value += stepSize
      case .down:
        value -= stepSize
      case .left, .right:
        print("\(direction) not supported for this action.")
        return .ignored
    }
    return .handled
  }

}
