//
//  GridPosition.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/10/2025.
//

import SwiftUI

/// This is like `CGPoint`
///
/// 📣 Important: ASCII-based / original GridPosition emphatically did
/// not allow negative values. Will need to evaluate impact of one
/// approach or the other, and be careful about refactoring.
///
/// ```
/// precondition(
///   row >= 0 && column >= 0,
///   "GridPosition cannot be negative, in either dimension."
/// )
/// ```
public struct GridPosition: ModelBase {
  public var column: Int  // x
  public var row: Int  // y

  public init(column: Int, row: Int) {
    self.column = column
    self.row = row
  }
}

extension GridPosition {

  public init(x: Int, y: Int) {
    self.init(column: x, row: y)
  }

  /// Cartesian X equivalent (Column)
  public var x: Int { column }

  /// Cartesian Y equivalent (Row)
  public var y: Int { row }

  /// `cellSize` is the width and height in points
  /// of a single cell in the current `GridCanvas`.
  /// It is not affected by zoom, it operates in local
  /// Canvas Space
  ///
  /// `point` must already be mapped to local Canvas space
  //  public init(
  //    point: CGPoint,
  //    cellSize: CGSize
  //  ) {
  //    /// `floor()` here maps a continuous coordinate to the
  //    /// nearest lower integer, effectively identifying which grid cell
  //    /// the point belongs to.
  //    let col = Int(floor(point.x / cellSize.width))
  //    let row = Int(floor(point.y / cellSize.height))
  //
  //    self.init(row: row, column: col)
  //  }

  public init(_ column: Int, _ row: Int) {
    self.column = column
    self.row = row
  }

  public var isOrigin: Bool { row == 0 && column == 0 }

  public func isLastRow(in grid: GridDimensions) -> Bool {
    let rowCount = grid.height
    return row >= rowCount - 1
  }

  public func isLastColumn(in grid: GridDimensions) -> Bool {
    let colCount = grid.width
    return column >= colCount - 1
  }

  public func toUnitPoint(in grid: GridDimensions) -> UnitPoint {
    /// Map discrete grid coordinates to a continuous UnitPoint in [0, 1].
    /// Interpret (column, row) as the top-left corner of the cell and map to the cell center.
    /// Handle degenerate grids (zero width/height) by returning .zero to avoid division by zero.
    let width = max(grid.width, 1)
    let height = max(grid.height, 1)

    /// Clamp to valid indices to keep UnitPoint within [0, 1].
    let clampedColumn = min(max(column, 0), width - 1)
    let clampedRow = min(max(row, 0), height - 1)

    /// Normalise to [0, 1] using cell centers. For N columns, centers are at (0.5/N, 1.5/N, ..., (N-0.5)/N).
    let x = (CGFloat(clampedColumn) + 0.5) / CGFloat(width)
    let y = (CGFloat(clampedRow) + 0.5) / CGFloat(height)

    return UnitPoint(x: x, y: y)
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
