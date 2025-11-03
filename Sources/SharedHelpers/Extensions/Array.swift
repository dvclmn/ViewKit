//
//  Array.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/5/2025.
//

import SwiftUI

extension Array where Element: Hashable {
  /// Notes on conversion from Array to Set:
  ///
  /// Duplicate handling is the big one. Arrays can contain duplicates, but Sets cannot. When you convert [1, 2, 2, 3] to a Set, you silently lose information - the resulting Set will only contain {1, 2, 3}. This might be intentional for deduplication, but could be surprising if someone expects all elements to be preserved.
  ///
  /// Element type constraints matter. Sets require their elements to conform to Hashable. If you put this on a generic Collection extension, it will only be available when the element type is Hashable, but this constraint might not be immediately obvious to callers.
  /// Performance characteristics change dramatically. Collections might be optimized for sequential access, while Sets are optimized for membership testing. The conversion itself is O(n), but the usage patterns afterward will be completely different.
  /// Ordering is lost. Collections maintain insertion/index order, but Sets don't guarantee any particular iteration order (though in practice Swift's Set maintains some ordering). Code that depends on element order will break.
  /// Identity vs equality considerations. If your collection contains reference types, the Set will use the Hashable implementation, which typically relies on equality rather than identity. Two different instances that are "equal" will be deduplicated.

  public func toSet() -> Set<Element> {
    return Set(self)
  }

}

// MARK: - Reusable Array stacking extensions

extension Array where Element: Collection {

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

  /// Stacks the entire array vertically by repeating it `count` times.
  /// E.g.,
  /// `[[A, B], [C, D]] vertically, count: 2`
  /// results in
  /// `[[A, B], [C, D], [A, B], [C, D]]`
  private func stackedVertically(repeating count: Int) -> [[Element.Element]] {
    Array(repeating: self, count: count).flatMap { $0.map { Array($0) } }
  }

  /// Stacks each inner array horizontally by repeating its contents `count` times.
  /// E.g.
  /// `[[A, B], [C, D]] horizontally, count: 2`
  /// results in
  /// `[[A, B, A, B], [C, D, C, D]]`
  private func stackedHorizontally(repeating count: Int) -> [[Element.Element]] {
    self.map { Array(repeating: $0, count: count).flatMap { $0 } }
  }
}
