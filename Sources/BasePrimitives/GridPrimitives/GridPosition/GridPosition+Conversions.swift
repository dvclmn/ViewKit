//
//  GridPosition+Conversions.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/1/2026.
//

import SwiftUI

extension GridPosition {

  public func toScreenPoint(
    using unitSize: CGSize
  ) -> CGPoint {
    CGPoint(
      x: CGFloat(column) * unitSize.width,
      y: CGFloat(row) * unitSize.height
    )
  }
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
}

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

extension CGPoint {

  /// Returns the row and column index for a global pointer location
  /// Returns nil if the pointer is outside the grid boundaries
  public func gridPosition(
    geometry: GridGeometry
  ) -> GridPosition? {
    //    guard let geometry, let pointerLocation else { return nil }

    let point = Point<CanvasSpace>(fromPoint: self)
    return geometry.projection.gridPositionIfValid(from: point)
  }

}
