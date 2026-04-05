//
//  Position+Operators.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/12/2025.
//

public func + (lhs: GridPosition, rhs: GridPosition) -> GridPosition {
  GridPosition(
    column: lhs.column + rhs.column,
    row: lhs.row + rhs.row
  )
}

/// Negative positions were previously disallowed, but have since decided to
/// keep more in line with how CGPoint works. So no 
public func - (lhs: GridPosition, rhs: GridPosition) -> GridPosition {
  GridPosition(
    column: lhs.column - rhs.column,
    row: lhs.row - rhs.row
  )
}

/// Assumes Row-major ordering
extension GridPosition: Comparable {

  public static func < (lhs: Self, rhs: Self) -> Bool {
    (lhs.row, lhs.column) < (rhs.row, rhs.column)
  }

//  public static func > (lhs: Self, rhs: Self) -> Bool {
//    (lhs.row, lhs.column) > (rhs.row, rhs.column)
//  }
//
//  public static func >= (lhs: Self, rhs: Self) -> Bool {
//    (lhs.row, lhs.column) >= (rhs.row, rhs.column)
//  }
//  
//  public static func <= (lhs: Self, rhs: Self) -> Bool {
//    (lhs.row, lhs.column) <= (rhs.row, rhs.column)
//  }

}
