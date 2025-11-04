//
//  Array.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/5/2025.
//

import SwiftUI

protocol GridRepresentable {
  associatedtype Cell
  var gridHeight: Int { get }
  var gridWidth: Int { get }
  func elementAt(row: Int, column: Int) -> Cell?
}

extension Array: GridRepresentable where Element: Collection, Element.Index == Int {
  typealias Cell = Element.Element
  
  var gridHeight: Int { count }
  var gridWidth: Int { self.map { $0.count }.max() ?? 0 }
  
  func elementAt(row: Int, column: Int) -> Cell? {
    guard indices.contains(row) else { return nil }
    let rowArray = self[row]
    return rowArray.indices.contains(column) ? rowArray[column] : nil
  }
  
  // Additional grid operations
  func row(_ index: Int) -> Element? {
    indices.contains(index) ? self[index] : nil
  }
  
  func column(_ index: Int) -> [Cell]? {
    guard gridWidth > index else { return nil }
    return indices.compactMap { row in
      elementAt(row: row, column: index)
    }
  }
}

extension Array where Element: Hashable {

  public func toSet() -> Set<Element> {
    return Set(self)
  }

}

extension Array where Element == [Character] {

  public func stacked(
    along axis: Axis,
    repeating count: Int
  ) -> [[Character]] {
    switch axis {
      case .horizontal:
        stackedHorizontally(repeating: count)
      case .vertical:
        stackedVertically(repeating: count)
    }
  }

  /// Repeats the entire 2D grid vertically.
  /// e.g. `[["A","B"],["C","D"]] ×2 → [["A","B"],["C","D"],["A","B"],["C","D"]]`
  private func stackedVertically(repeating count: Int) -> [[Character]] {
    var result: [[Character]] = []
    result.reserveCapacity(self.count * count)

    for _ in 0..<count {
      result.append(contentsOf: self)
    }

    return result
  }

  /// Repeats each row horizontally.
  /// e.g. `[["A","B"],["C","D"]] ×2 → [["A","B","A","B"],["C","D","C","D"]]`
  private func stackedHorizontally(repeating count: Int) -> [[Character]] {
    self.map { row in
      var newRow: [Character] = []
      newRow.reserveCapacity(row.count * count)

      for _ in 0..<count {
        newRow.append(contentsOf: row)
      }

      return newRow
    }
  }
}
