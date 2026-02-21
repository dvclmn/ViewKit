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

// From
// https://fatbobman.com/en/snippet/extending-supported-data-types-for-appstorage/#2-supporting-arrays
extension Array: @retroactive RawRepresentable where Element: Codable {
  public init?(rawValue: String) {
    guard let data = rawValue.data(using: .utf8),
      let result = try? JSONDecoder().decode([Element].self, from: data)
    else {
      return nil
    }
    self = result
  }

  public var rawValue: String {
    guard let data = try? JSONEncoder().encode(self),
      let result = String(data: data, encoding: .utf8)
    else {
      return "[]"
    }
    return result
  }
}

extension Array where Element: Collection {
  /// Width of the widest row, or zero if none found
  public func width(for strategy: GridWidthStrategy = .widestRow) -> Int {
    switch strategy {
      case .firstRow: self.first?.count ?? 0
      case .widestRow: self.map { $0.count }.max() ?? 0
    }
  }
  
  public var rowCount: Int { self.count }
}

public enum GridWidthStrategy {
  case firstRow
  case widestRow
}


//extension Array where Element == [AnyHashable: Any] {
//  public func reduce() -> [AnyHashable: Any] {
//    self.reduce(into: [:]) { partial, dict in
//      partial.merge(dict) { _, new in new }
//    }
//  }
//
//}

//extension Array where Element == [Character] {
//
//  public func stacked(
//    along axis: Axis,
//    repeating count: Int
//  ) -> [[Character]] {
//    switch axis {
//      case .horizontal:
//        stackedHorizontally(repeating: count)
//      case .vertical:
//        stackedVertically(repeating: count)
//    }
//  }
//
//  /// Repeats the entire 2D grid vertically.
//  /// e.g. `[["A","B"],["C","D"]] ×2 → [["A","B"],["C","D"],["A","B"],["C","D"]]`
//  private func stackedVertically(repeating count: Int) -> [[Character]] {
//    var result: [[Character]] = []
//    result.reserveCapacity(self.count * count)
//
//    for _ in 0..<count {
//      result.append(contentsOf: self)
//    }
//
//    return result
//  }
//
//  /// Repeats each row horizontally.
//  /// e.g. `[["A","B"],["C","D"]] ×2 → [["A","B","A","B"],["C","D","C","D"]]`
//  private func stackedHorizontally(repeating count: Int) -> [[Character]] {
//    self.map { row in
//      var newRow: [Character] = []
//      newRow.reserveCapacity(row.count * count)
//
//      for _ in 0..<count {
//        newRow.append(contentsOf: row)
//      }
//
//      return newRow
//    }
//  }
//}

