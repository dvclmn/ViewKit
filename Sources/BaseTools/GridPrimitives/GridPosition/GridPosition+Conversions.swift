//
//  GridPosition+Conversions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/1/2026.
//

import SwiftUI


extension GridPosition {

  public func toScreenPoint(
    using unitSize: CGSize,
    mapping: AxisMapping = .default
  ) -> CGPoint {
    GridScreenConversion.screenPoint(
      for: self,
      unitSize: unitSize,
      mapping: mapping
    )
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

  @available(
    *, deprecated,
    message: "Ambiguous. Use toScreenPoint(using:) for pixel space or toUnitPoint(in:) for unit space."
  )
  public func toUnitPoint(using unitSize: CGSize) -> UnitPoint? {
    let x = column.toScreenLength(using: unitSize.width)
    let y = row.toScreenLength(using: unitSize.height)
    return UnitPoint(x: x, y: y)
  }

  public func toIndex(columns: Int) -> Int {
    row * columns + column
  }
}

// MARK: - UnitPoint

extension UnitPoint {
  public func toGridPosition(
    in dimensions: GridDimensions,
    rounding: GridRounding
  ) -> GridPosition {

    let colThing: CGFloat = x * CGFloat(dimensions.width)
    let rowThing: CGFloat = y * CGFloat(dimensions.height)

    let colRounded = colThing.roundedInt(using: rounding)
    let rowRounded = rowThing.roundedInt(using: rounding)

    return GridPosition(colRounded, rowRounded)
  }

}

// MARK: - CGPoint

extension CGPoint {

  /// Returns the row and column index for a global pointer location
  /// Returns nil if the pointer is outside the grid boundaries
  public func gridPosition(in geometry: GridGeometry) -> GridPosition? {
    guard
      geometry.dimensions.contains(
        point: self,
        unitSize: geometry.projection.unitSize
      )
    else { return nil }

    let point = Point<CanvasSpace>(fromPoint: self)
    guard let candidate = geometry.projection.gridPositionIfValid(from: point) else {
      return nil
    }
    return geometry.dimensions.contains(position: candidate) ? candidate : nil
  }

}
