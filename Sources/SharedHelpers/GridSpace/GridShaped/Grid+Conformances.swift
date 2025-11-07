//
//  Grid+Conformances.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/11/2025.
//

import SwiftUI

// MARK: - Collection conformance
extension GridShaped {

  public var startIndex: Int { cells.startIndex }
  public var endIndex: Int { cells.endIndex }

  public subscript(position: Int) -> Row {
    return cells[position]
  }

  public func index(after i: Int) -> Int {
    return cells.index(after: i)
  }

  public func mapRows<T>(_ transform: (Row) -> T) -> [T] {
    cells.map(transform)
  }

  //  public func flatMap<T>(_ transform: (Row) -> T) -> [T] {
  //    cells.map(transform)
  //  }

  public func enumerated() -> EnumeratedSequence<Cells> {
    cells.enumerated()
  }

  public mutating func append(_ row: Row) {
    cells.append(row)
  }

  public init(
    repeating grid: Self,
    count: Int,
    along axis: Axis
  ) {
    switch axis {
      case .horizontal:
        self.init(
          grid.cells.map {
            Array(repeating: $0, count: count).flatMap { $0 }
          })
      case .vertical:
        self.init(Array(repeating: grid.cells, count: count).flatMap { $0 })
    }
  }
}
