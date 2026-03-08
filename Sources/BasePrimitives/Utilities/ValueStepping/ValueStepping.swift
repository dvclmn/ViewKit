//
//  ValueStepping.swift
//  DrawString
//
//  Created by Assistant on 5/3/2026.
//

import Foundation

// MARK: - Collection helpers (Comparable fallback when `current` not found)

extension Collection where Element: Comparable {
  /// Returns the next logical element after `current`.
  /// If `current` is present, returns the following element (or wraps if requested).
  /// If `current` is not present, returns the first element that is strictly greater than `current`.
  public func nextValueLoosely(after current: Element, wrapping: Bool = false) -> Element? {
    let array = Array(self)
    if let exact = array.firstIndex(of: current) {
      return array.nextValue(after: array[exact], wrapping: wrapping)
    }
    // Fallback: choose the smallest element greater than current
    if let nextGreater = array.sorted().first(where: { $0 > current }) {
      return nextGreater
    }
    return wrapping ? array.sorted().first : nil
  }

  /// Returns the previous logical element before `current`.
  /// If `current` is present, returns the preceding element (or wraps if requested).
  /// If `current` is not present, returns the greatest element that is strictly less than `current`.
  public func previousValueLoosely(before current: Element, wrapping: Bool = false) -> Element? {
    let array = Array(self)
    if let exact = array.firstIndex(of: current) {
      return array.previousValue(before: array[exact], wrapping: wrapping)
    }
    // Fallback: choose the greatest element less than current
    let sorted = array.sorted()
    if let idx = sorted.lastIndex(where: { $0 < current }) {
      return sorted[idx]
    }
    return wrapping ? sorted.last : nil
  }

  /// Steps by +1/-1 loosely, handling values not exactly present in the collection.
  public func valueLoosely(
    steppingFrom current: Element, direction: StepDirection, wrapping: Bool = false
  ) -> Element? {
    switch direction {
      case .up: return nextValueLoosely(after: current, wrapping: wrapping)
      case .down: return previousValueLoosely(before: current, wrapping: wrapping)
    }
  }
}

// MARK: - Value-centric helpers

extension Comparable {
  /// Returns a value stepped by one position within `allowed`, with a fallback when the current value
  /// isn't exactly present: choose the next greater (for `.up`) or next lesser (for `.down`) element.
  public func steppedLoosely(
    in allowed: [Self],
    direction: StepDirection = .up,
    wrapping: Bool = false
  ) -> Self? {
    switch direction {
      case .up: return allowed.nextValueLoosely(after: self, wrapping: wrapping)
      case .down: return allowed.previousValueLoosely(before: self, wrapping: wrapping)
    }
  }
}


// MARK: - Usage Examples

/*
 Example: stepping interface font size using predefined steps.

 let steps = Constants.interfaceFontSizeSteps // [9, 12, 16, 24, 36]
 var size: CGFloat = 18
 // Not exactly in the list; loosely step up picks 24
 if let next = size.steppedLoosely(in: steps, direction: .up) {
   size = next // 24
 }

 // With SwiftUI Binding:
 struct ExampleView: View {
   @State private var size: CGFloat = 18
   var body: some View {
     HStack {
       Button("-") { $size.stepLoosely(in: steps, direction: .down) }
       Button("+") { $size.stepLoosely(in: steps, direction: .up) }
     }
   }
 }
*/
