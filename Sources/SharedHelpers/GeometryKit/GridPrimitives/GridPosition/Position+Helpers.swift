//
//  Position+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/12/2025.
//

import SwiftUI

extension GridPosition {

  /// Returns a position guaranteed to be within the provided dimensions.
  /// Returns `0` for a row/column if it falls outside these dimensions.
  /// Not suitable for cases where you *only want a position* if it falls inside.
  public func clamped(
    to dimensions: GridDimensions
  ) -> GridPosition {
    let clampedColumn = max(0, min(dimensions.width - 1, column))
    let clampedRow = max(0, min(dimensions.height - 1, row))
    return GridPosition(column: clampedColumn, row: clampedRow)
  }

  /// Creates a GridPosition only if contained within the
  /// provided `GridDimensions`
  public static func createIfContained(
    within dimensions: GridDimensions,
    at point: CGPoint,
    cellSize: CGSize
  ) -> GridPosition? {

    fatalError("Needs implementation")
    //    /// The grid size conversion is *only* to check whether the point is contained.
    //    /// The cellSize is not used to construct the
    //    let gridSize = dimensions.toUnitSize(unitSize: cellSize)
    //    let containsPoint = gridSize.contains(point: point)
    //
    //    let position = GridPosition(<#T##row: Int##Int#>, <#T##column: Int##Int#>)
    //    guard dimensions.contains(point: point, cellSize: cellSize) else { return nil }
    //    return GridPosition(point: point, cellSize: cellSize)
  }

  /// Note: zero-based count for internal representation,
  /// one-based for user-facing UI
  public static var zero: GridPosition {
    GridPosition(column: 0, row: 0)
  }

  /// Position starting from one, for UI
  public var displayRepresentation: GridPosition {
    GridPosition(column: column + 1, row: row + 1)
    //    self + 1
  }

  public var isGreaterThanZero: Bool {
    return column > 0 && row > 0
  }

  public var isGreaterThanOrEqualToZero: Bool {
    return column >= 0 && row >= 0
  }

  /// Converts grid position to canvas-space point
  /// - Parameter cellSize: The size of each grid cell
  /// - Returns: The top-left point of the cell in canvas coordinates
  //  public func toCGPoint(cellSize: CGSize) -> CGPoint {
  //    CGPoint(
  //      x: CGFloat(column) * cellSize.width,
  //      y: CGFloat(row) * cellSize.height
  //    )
  //  }

  public func toUnitPoint(using unitSize: CGSize) -> UnitPoint? {
    guard let x = row.toScreenLength(using: unitSize.width),
      let y = column.toScreenLength(using: unitSize.height)
    else { return nil }
    return UnitPoint(
      x: x,
      y: y
    )
    //    CGPoint(
    //      x: CGFloat(column) * cellSize.width,
    //      y: CGFloat(row) * cellSize.height
    //    )
  }

  public func toScreenPoint(
    using unitSize: CGSize
  ) -> CGPoint {
    CGPoint(
      x: CGFloat(column) * unitSize.width,
      y: CGFloat(row) * unitSize.height
    )
  }

  public func neighbour(at edge: GridEdge) -> GridPosition {
    //  public func neighbour(at edge: Edge) -> GridPosition {
    let delta = edge.directionVector
    return GridPosition(
      column: max(0, column + delta.column),
      row: max(0, row + delta.row),
    )
  }

  public func toCGRect(cellSize: CGSize) -> CGRect {
    CGRect(
      x: CGFloat(column) * cellSize.width,
      y: CGFloat(row) * cellSize.height,
      width: cellSize.width,
      height: cellSize.height
    )
  }

  public func toIndex(columns: Int) -> Int {
    row * columns + column
  }

  /// Basic offset methods
  public func offsetBy(row deltaRow: Int, col deltaCol: Int) -> GridPosition {
    GridPosition(
      column: column + deltaCol,
      row: row + deltaRow,
    )
  }

  public mutating func offsetting(by delta: GridPosition) {
    let current = self
    self = current + delta
  }

  public mutating func offsetting(_ direction: Direction, by delta: Int = 1) {
    let (newCol, newRow) = direction.offset(x: column, y: row, by: delta)
    let position = GridPosition(column: newCol, row: newRow)
    print("GridPosition from `offsetting(_ direction: Direction...)`: \(position)")
    self = position
  }

  public func isValidWithin(dimensions: GridDimensions) -> Bool {
    return dimensions.contains(position: self)
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
    //    let wrappedCol = (offset.x % gridDimensions.columns + gridDimensions.columns) % gridDimensions.columns
    //    let wrappedRow = (offset.y % gridDimensions.rows + gridDimensions.rows) % gridDimensions.rows
    //
    //    return GridPosition(column: wrappedCol, row: wrappedRow)
  }

  //  public func moved(
  //    in direction: Direction,
  //    by delta: Int = 1,
  //    gridDimensions: GridDimensions
  //  ) -> GridPosition {
  //    let offset = direction.offset(x: column, y: row, by: delta)
  //
  //    let newPosition = GridPosition(column: offset.x, row: offset.y)
  //    let wrappedPosition = newPosition.wrapped(
  //      columns: gridDimensions.columns,
  //      rows: gridDimensions.rows
  //    )
  //    precondition(
  //      wrappedPosition.isValidWithin(dimensions: gridDimensions),
  //      "Cell position of \(wrappedPosition) is out of bounds in grid dimensions \(gridDimensions).")
  //
  //    return wrappedPosition
  //  }

  //  public func wrapped(columns: Int, rows: Int) -> GridPosition {
  //    let wrappedCol = (column % columns + columns) % columns
  //    let wrappedRow = (row % rows + rows) % rows
  //    return GridPosition(column: wrappedCol, row: wrappedRow)
  //  }

  /// Column and Row as 'raw' `Int`s are used here, intead of a `GridPosition`,
  /// as `GridPosition` cannot represent negative values
  public static func wrapped(
    column: Int,
    row: Int,
    in dimensions: GridDimensions
  ) -> GridPosition {
    let (columns, rows) = (dimensions.width, dimensions.height)

    let wrappedCol = (column % columns + columns) % columns
    let wrappedRow = (row % rows + rows) % rows
    return GridPosition(column: wrappedCol, row: wrappedRow)
  }
}
