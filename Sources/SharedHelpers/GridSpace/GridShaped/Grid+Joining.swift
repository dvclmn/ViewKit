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
    Self(self.cells + other.cells)
  }

  private func joinedHorizontally(
    with other: Self
  ) -> Self {

    //    let combined: Cells = Self.zipLongest(
    //      self.cells,
    //      other.cells,
    //      fillA: [],
    //      fillB: []
    //    ).map { lhsRow, rhsRow in
    //      lhsRow + rhsRow
    //    }
    //
    //    return Self(combined)

    let maxHeight = Swift.max(self.height, other.height)

    var result = self

    for i in 0..<maxHeight {
      let lhs = self[row: i]
      let rhs = other[row: i]

      result.append(lhs + rhs)
    }
    return result
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

extension GridShaped {
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
  //  static func zipLongest<A, B>(
  //    _ a: [A],
  //    _ b: [B],
  //    fillA: @autoclosure () -> A,
  //    fillB: @autoclosure () -> B
  //  ) -> [(A, B)] {
  //    let maxCount = Swift.max(a.count, b.count)
  //    return (0..<maxCount).map { i in
  //      let lhs = i < a.count ? a[i] : fillA()
  //      let rhs = i < b.count ? b[i] : fillB()
  //      return (lhs, rhs)
  //    }
  //  }
}
