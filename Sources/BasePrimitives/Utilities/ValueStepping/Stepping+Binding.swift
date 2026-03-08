//
//  Stepping+Binding.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/3/2026.
//

import SwiftUI

extension Binding where Value: Equatable {
  /// Steps the wrapped value within `allowed`.
  public func step(
    in allowed: [Value],
    direction: StepDirection = .up,
    wrapping: Bool = false
  ) {
    if let next = wrappedValue.stepped(
      in: allowed,
      direction: direction,
      wrapping: wrapping
    ) {
      wrappedValue = next
    }
  }
}

extension Binding where Value: Comparable {
  /// Steps the wrapped value within `allowed`, with a fallback when the current value
  /// isn't exactly present in `allowed`.
  public func stepLoosely(
    in allowed: [Value],
    direction: StepDirection = .up,
    wrapping: Bool = false
  ) {
    if let next = wrappedValue.steppedLoosely(
      in: allowed,
      direction: direction,
      wrapping: wrapping
    ) {
      wrappedValue = next
    }
  }
}


extension Equatable {
  /// Returns a value stepped by one position within `allowed`.
  /// - Parameters:
  ///   - allowed: Ordered list of allowed values.
  ///   - direction: `.up` for next, `.down` for previous.
  ///   - wrapping: If true, stepping beyond the ends wraps around.
  /// - Returns: The stepped value, or `nil` if stepping is not possible.
  fileprivate func stepped(
    in allowed: [Self],
    direction: StepDirection = .up,
    wrapping: Bool = false
  ) -> Self? {
    switch direction {
      case .up: return allowed.nextValue(after: self, wrapping: wrapping)
      case .down: return allowed.previousValue(before: self, wrapping: wrapping)
    }
  }
  
  /// Mutates `self` to the stepped value within `allowed` if possible.
  fileprivate mutating func stepInPlace(
    in allowed: [Self],
    direction: StepDirection = .up,
    wrapping: Bool = false
  )
  {
    if let v = self.stepped(in: allowed, direction: direction, wrapping: wrapping) {
      self = v
    }
  }
}
