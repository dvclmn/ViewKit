//
//  Stepping+Equatable.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/3/2026.
//

import Foundation

extension Collection where Element: Equatable {
  /// Returns the next element after `current` within this collection, or `nil` if `current` is not found
  /// and no Comparable-based fallback is available.
  /// - Parameters:
  ///   - current: The current value.
  ///   - wrapping: If true, stepping beyond the end wraps to the first element.
  /// - Returns: The next element, or `nil`.
  public func nextValue(after current: Element, wrapping: Bool = false) -> Element? {
    let array = Array(self)
    guard let idx = array.firstIndex(of: current) else { return nil }
    let nextIndex = array.index(after: idx)
    guard nextIndex < array.endIndex else {
      return wrapping ? array.first : nil
    }
    return array[nextIndex]
  }

  /// Returns the previous element before `current` within this collection, or `nil` if `current` is not found
  /// and no Comparable-based fallback is available.
  /// - Parameters:
  ///   - current: The current value.
  ///   - wrapping: If true, stepping before the start wraps to the last element.
  /// - Returns: The previous element, or `nil`.
  public func previousValue(before current: Element, wrapping: Bool = false) -> Element? {
    let array = Array(self)
    guard let idx = array.firstIndex(of: current) else { return nil }
    guard idx > array.startIndex else {
      return wrapping ? array.last : nil
    }
    return array[array.index(before: idx)]
  }

  /// Returns the element stepping `steps` positions from `current` within this collection.
  /// Positive `steps` step forward; negative `steps` step backward.
  /// Returns `nil` if `current` is not found and no Comparable-based fallback is available.
  /// - Parameters:
  ///   - current: The current value.
  ///   - steps: Number of steps to move; positive to step forward, negative to step backward.
  ///   - wrapping: If true, indexes wrap around the collection bounds.
  public func value(steppingFrom current: Element, by steps: Int, wrapping: Bool = false) -> Element? {
    guard steps != 0 else { return current }
    let array = Array(self)
    guard let idx = array.firstIndex(of: current) else { return nil }
    let count = array.count
    guard count > 0 else { return nil }

    let base = array.distance(from: array.startIndex, to: idx)
    let target = base + steps

    guard wrapping else {
      let clamped = Swift.min(Swift.max(target, 0), count - 1)
      guard clamped != base else { return nil }
      return array[clamped]
    }
    let wrappedIndex = ((target % count) + count) % count
    return array[wrappedIndex]
  }
}
