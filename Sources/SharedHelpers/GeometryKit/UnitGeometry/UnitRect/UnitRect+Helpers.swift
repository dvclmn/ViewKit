//
//  UnitRect+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/1/2026.
//

import Foundation

extension UnitRect {

  /// Iterates over all `GridPositions` within this `UnitRect`
  public func gridPositions() -> [GridPosition] {
    let startCol = origin.x.magnitude
    let startRow = origin.y.magnitude
    let width = size.width.magnitude
    let height = size.height.magnitude

    return (startRow..<startRow + height).flatMap { row in
      (startCol..<startCol + width).map { col in
        GridPosition(column: col, row: row)
      }
    }
  }
  
  public func contains(_ position: GridPosition) -> Bool {
    let rowRange = origin.y..<(origin.y + size.height)
    let colRange = origin.x..<(origin.x + size.width)
    return rowRange.contains(position.row) && colRange.contains(position.column)
  }
}
