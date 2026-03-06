//
//  Grid+Conformances.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/11/2025.
//

import SwiftUI

// MARK: - Collection conformance
extension GridShaped {

  public var startIndex: Int { rows.startIndex }
  public var endIndex: Int { rows.endIndex }

  /// This is required, by `Collection`, to be non-optional.
  /// I believe this `position` would correspond to Row.
  /// Consider safer alternative `subscript(row rowIndex: Int) -> Row?`
  public subscript(position: Int) -> Row {
    return rows[position]
  }

  public func index(after i: Int) -> Int {
    return rows.index(after: i)
  }

  public func mapRows<T>(_ transform: (Row) -> T) -> [T] {
    rows.map(transform)
  }

  public func enumerated() -> EnumeratedSequence<Rows> {
    rows.enumerated()
  }

  public mutating func append(_ row: Row) {
    rows.append(row)
  }

  public init(
    repeating grid: Self,
    count: Int,
    along axis: Axis
  ) {
    switch axis {
      case .horizontal:
        self.init(
          grid.rows.map {
            Array(repeating: $0, count: count).flatMap { $0 }
          })
      case .vertical:
        self.init(Array(repeating: grid.rows, count: count).flatMap { $0 })
    }
  }
}
