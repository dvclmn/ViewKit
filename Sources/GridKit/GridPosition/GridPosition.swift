//
//  GridPosition.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/10/2025.
//

import Foundation

/// This is like `CGPoint`
///
/// 📣 Important: ASCII-based / original GridPosition emphatically did
/// not allow negative values. Will need to evaluate impact of one
/// approach or the other, and be careful about refactoring.
/// ```
/// precondition(
///   row >= 0 && column >= 0,
///   "GridPosition cannot be negative, in either dimension."
/// )
/// ```
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

  /// `cellSize` is the width and height in points
  /// of a single cell in the current `GridCanvas`.
  /// It is not affected by zoom, it operates in local
  /// Canvas Space
  ///
  /// `point` must already be mapped to local Canvas space
  public init(
    point: CGPoint,
    cellSize: CGSize
  ) {
    /// `floor()` here maps a continuous coordinate to the
    /// nearest lower integer, effectively identifying which grid cell
    /// the point belongs to.
    let col = Int(floor(point.x / cellSize.width))
    let row = Int(floor(point.y / cellSize.height))

    self.init(row: row, column: col)
  }

  public init(_ row: Int, _ column: Int) {
    self.row = row
    self.column = column
  }

  //  var row: Int { x }
  //  var column: Int { y }
}



extension GridPosition: CustomStringConvertible {
  public var description: String {
    "R\(row) C\(column)"
    //    "(\(row), \(column))"
  }
}
