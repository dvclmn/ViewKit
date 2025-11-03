//
//  Array.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/5/2025.
//

import SwiftUI

extension Array where Element: Hashable {

  public func toSet() -> Set<Element> {
    return Set(self)
  }

}

// MARK: - Reusable Array stacking extensions

extension Array where Element: Collection {

  public func stacked(along axis: Axis, repeating count: Int) -> [[Element.Element]] {
    switch axis {
      case .horizontal:
        stackedHorizontally(repeating: count)
      case .vertical:
        stackedVertically(repeating: count)
    }
  }

  //  public func stacked(
  //    along axis: Axis,
  //    repeating count: Int
  //  ) -> [[Element.Element]] {
  //    switch axis {
  //      case .horizontal:
  //        stackedHorizontally(repeating: count)
  //      case .vertical:
  //        stackedHorizontally(repeating: count)
  //    }
  //  }

  /// ```
  /// let tile: [[Character]] = [
  ///   ["═"],
  ///   ["━"]
  /// ]
  ///
  /// let v = tile.stackedVertically(repeating: 2)
  /// print(v)
  /// // [["═"], ["━"], ["═"], ["━"]]
  ///
  /// let h = tile.stackedHorizontally(repeating: 3)
  /// print(h)
  /// // [["═", "═", "═"], ["━", "━", "━"]]
  ///
  /// ```

  /// Vertically repeats the array of collections.
  /// e.g. `[[A, B], [C, D]] * 2 → [[A, B], [C, D], [A, B], [C, D]]`
  func stackedVertically(repeating count: Int) -> [[Element.Element]] {
    var result: [[Element.Element]] = []
    result.reserveCapacity(self.count * count)

    for _ in 0..<count {
      for inner in self {
        result.append(Array(inner))
      }
    }
    return result
  }

  /// Horizontally repeats each collection within the array.
  /// e.g. `[[A, B], [C, D]] * 2 → [[A, B, A, B], [C, D, C, D]]`
  func stackedHorizontally(repeating count: Int) -> [[Element.Element]] {
    self.map { inner in
      var row: [Element.Element] = []
      row.reserveCapacity(inner.count * count)

      for _ in 0..<count {
        row.append(contentsOf: inner)
      }
      return row
    }
  }
}
