//
//  Joining.swift
//  TextCore
//
//  Created by Dave Coleman on 14/9/2024.
//

import SwiftUI

extension StringStack {
  public static func joined(
    _ stacks: [StringStack],
    along axis: Axis,
    padding: Character? = nil
  ) -> StringStack {
    return stacks.reduce(StringStack([])) { partial, stack in
      StringStack.joined(partial, stack, along: axis, padding: padding)
    }
  }

  public static func joined(
    _ stacks: StringStack...,
    along axis: Axis,
    padding: Character? = nil
  ) -> StringStack {
    stacks.reduce(StringStack([])) { partial, string in
      switch axis {
        case .horizontal:
          partial.joinedHorizontally(with: string, padding: padding)

        case .vertical:
          partial.joinedVertically(with: string, padding: padding)
      }
    }
  }

  private func joinedHorizontally(
    with other: StringStack,
    padding char: Character? = nil
  ) -> StringStack {
    let maxHeight = Swift.max(self.height, other.height)
    var result = StringStack([])

    for i in 0..<maxHeight {

      let lhs = self[row: i]
      let rhs = other[row: i]

      guard let char else {
        /// No padding required, just join what's here
        result.append(lhs + rhs)
        continue
      }

      /// Create and append padding
      let lhsPadding = Self.createPadding(for: self, with: char)
      let rhsPadding = Self.createPadding(for: other, with: char)

      result.append(lhsPadding + lhs + rhs + rhsPadding)
    }
    return result
  }

  private func joinedVertically(with other: StringStack, padding: Character? = nil) -> StringStack {
    let maxWidth = Swift.max(width, other.width)
    var result = self

    for i in 0..<other.height {
      let row = other.row(at: i, paddedTo: maxWidth, with: padding)
      result.append(row)
    }

    return result
  }

  private static func createPadding(
    for stack: Self,
    with char: Character?,
  ) -> [Character] {
    guard let char else { return [] }
    return Array(repeating: char, count: stack.width)
  }
}


/// Assumes horizontal joining
public func + (lhs: StringStack, rhs: StringStack) -> StringStack {
  return StringStack.joined(lhs, rhs, along: .horizontal)
}

public func += (lhs: inout StringStack, rhs: StringStack) {
  lhs = lhs + rhs
}
