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
