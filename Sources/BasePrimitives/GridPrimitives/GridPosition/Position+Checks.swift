//
//  Position+Checks.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/3/2026.
//

import Foundation

extension GridPosition {

  public var isOrigin: Bool { row == 0 && column == 0 }

  public func isLastRow(in grid: GridDimensions) -> Bool {
    let rowCount = grid.height
    return row >= rowCount - 1
  }

  public func isLastColumn(in grid: GridDimensions) -> Bool {
    let colCount = grid.width
    return column >= colCount - 1
  }

  public var isGreaterThanZero: Bool {
    return column > 0 && row > 0
  }

  public var isGreaterThanOrEqualToZero: Bool {
    return column >= 0 && row >= 0
  }

  public func isValidWithin(dimensions: GridDimensions) -> Bool {
    return dimensions.contains(position: self)
  }
}
