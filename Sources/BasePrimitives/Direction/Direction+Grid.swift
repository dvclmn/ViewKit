//
//  Direction+Grid.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import Foundation

extension GridPosition {
  public mutating func offsetting(_ direction: Direction, by delta: Int = 1) {
    let (newCol, newRow) = direction.offset(x: column, y: row, by: delta)
    let position = GridPosition(column: newCol, row: newRow)
    print("GridPosition from `offsetting(_ direction: Direction...)`: \(position)")
    self = position
  }

  public func moved(
    in direction: Direction,
    by delta: Int = 1,
    gridDimensions: GridDimensions
  ) -> GridPosition {
    let offset = direction.offset(x: column, y: row, by: delta)
    
    /// Wrap raw x/y before creating the new GridPosition, otherwise
    /// the position could get initialised with a negative number
    let wrappedPosition = GridPosition.wrapped(
      column: offset.x,
      row: offset.y,
      in: gridDimensions
    )
    return wrappedPosition
  }

}
