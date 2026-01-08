//
//  Position+Operators.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/12/2025.
//

public func + (lhs: GridPosition, rhs: GridPosition) -> GridPosition {
  return GridPosition(column: lhs.column + rhs.column, row: lhs.row + rhs.row)
}

extension GridPosition: Comparable {
  
  public static func < (lhs: Self, rhs: Self) -> Bool {
    (lhs.row, lhs.column) < (rhs.row, rhs.column)
  }
  
  //  public static func < (lhs: GridPosition, rhs: GridPosition) -> Bool {
  //    return (lhs.row < rhs.row) || ((lhs.row == rhs.row) && (lhs.column < rhs.column))
  //  }
}
