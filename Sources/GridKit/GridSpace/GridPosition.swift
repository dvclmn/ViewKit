//
//  GridPosition.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/10/2025.
//

/// This is like `CGPoint`
public struct GridPosition: Hashable {
  public let row: Int
  public let column: Int

  public init(row: Int, column: Int) {
    self.row = row
    self.column = column
  }
  //  public let x: Int
  //  public let y: Int

  //  public init(x: Int, y: Int) {
  //    self.x = x
  //    self.y = y
  //  }
}

extension GridPosition {

  public init(_ row: Int, _ column: Int) {
    self.row = row
    self.column = column
  }

  //  var row: Int { x }
  //  var column: Int { y }
}

extension GridPosition: Comparable {

  public static func < (lhs: Self, rhs: Self) -> Bool {
    (lhs.row, lhs.column) < (rhs.row, rhs.column)
  }

  //  public static func < (lhs: GridPosition, rhs: GridPosition) -> Bool {
  //    return (lhs.row < rhs.row) || ((lhs.row == rhs.row) && (lhs.column < rhs.column))
  //  }
}

extension GridPosition: CustomStringConvertible {
  public var description: String {
    "R\(row) C\(column)"
    //    "(\(row), \(column))"
  }
}
