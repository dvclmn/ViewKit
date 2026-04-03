//
//  Position+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/12/2025.
//

import SwiftUI
import InteractionKit

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

  public func clampedIfNeeded(
    to dimensions: GridDimensions?
  ) -> GridPosition {
    guard let dimensions else { return self }
    return clamped(to: dimensions)
  }

  func clamped(to width: Int, height: Int) -> GridPosition {
    GridPosition(
      column: max(0, min(column, width - 1)),
      row: max(0, min(row, height - 1))
    )
  }

  /// Creates a GridPosition only if contained within the
  /// provided `GridDimensions`
  public static func createIfContained(
    within dimensions: GridDimensions,
    at point: CGPoint,
    cellSize: CGSize,
    rounding: GridRounding = .down
  ) -> GridPosition? {
    let projection = GridProjection(
      unitSize: cellSize,
      rounding: rounding
    )
    let canvasPoint = Point<CanvasSpace>(fromPoint: point)
    guard let candidate = projection.gridPositionIfValid(from: canvasPoint) else {
      return nil
    }
    return dimensions.contains(position: candidate) ? candidate : nil

  }

  /// Note: zero-based count for internal representation,
  /// one-based for user-facing UI
  public static var zero: GridPosition {
    GridPosition(column: 0, row: 0)
  }

  /// Position starting from one, for UI
  public var displayRepresentation: GridPosition {
    GridPosition(column: column + 1, row: row + 1)
  }

  /// This previously clamped to a min of zero, but no longer
  /// does, since allowing negative positions
  public func neighbour(at edge: GridEdge) -> GridPosition {
    let delta = edge.directionVector
    return GridPosition(
      column: column + delta.column,
//      column: max(0, column + delta.column),
      row: row + delta.row,
//      row: max(0, row + delta.row),
    )
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

}
