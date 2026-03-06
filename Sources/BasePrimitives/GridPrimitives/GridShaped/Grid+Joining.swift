//
//  Grid+Joining.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/11/2025.
//

import SwiftUI

extension GridShaped {

  public static func joined(
    _ others: Self...,
    along axis: Axis,
  ) -> Self {
    Self.joined(others, along: axis)
  }

  public static func joined(
    _ others: [Self],
    along axis: Axis,
  ) -> Self {
    others.reduce(Self([])) { partial, grid in
      switch axis {
        case .horizontal:
          partial.joinedHorizontally(with: grid)
        case .vertical:
          partial.joinedVertically(with: grid)
      }
    }
  }

  private func joinedVertically(with other: Self) -> Self {
    Self(self.rows + other.rows)
  }

  private func joinedHorizontally(
    with other: Self
  ) -> Self {
    let combined = Self.zipLongest(self.rows, other.rows, fill: [])
      .map(+)
    return Self(combined)
  }

  static func zipLongest<T>(
    _ a: [T],
    _ b: [T],
    fill: @autoclosure () -> T
  ) -> [(T, T)] {
    let maxCount = Swift.max(a.count, b.count)
    return (0..<maxCount).map { i in
      let lhs = i < a.count ? a[i] : fill()
      let rhs = i < b.count ? b[i] : fill()
      return (lhs, rhs)
    }
  }
}

/// Assumes horizontal joining
public func + <T: GridShaped>(lhs: T, rhs: T) -> T {
  T.joined(lhs, rhs, along: .horizontal)
}

/// Joins horizontally
public func += <T: GridShaped>(lhs: inout T, rhs: T) {
  lhs = lhs + rhs
}
