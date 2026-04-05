//
//  Grid+Conformances.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/11/2025.
//

import SwiftUI

// MARK: - Positioned cell entry

/// A cell value paired with its position in a grid.
/// `position` serves as the SwiftUI identity — use `id: \.position` in ForEach.
public struct GridEntry<Cell: GridCell>: Sendable {
  public let position: GridPosition
  public let cell: Cell
}

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

  /// A lazy sequence of every cell paired with its `GridPosition`.
  /// Use `id: \.position` in SwiftUI `ForEach` — position is the stable spatial identity.
  ///
  ///     ForEach(grid.positionedCells, id: \.position) { entry in
  ///         CellView(entry.cell, at: entry.position)
  ///     }
  public var positionedCells: some Sequence<GridEntry<Cell>> {
    rows.lazy.enumerated().flatMap { rowIndex, row in
      row.lazy.enumerated().map { colIndex, cell in
        GridEntry(position: GridPosition(column: colIndex, row: rowIndex), cell: cell)
      }
    }
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
