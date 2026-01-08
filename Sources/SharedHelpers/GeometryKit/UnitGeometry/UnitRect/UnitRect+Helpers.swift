//
//  UnitRect+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/1/2026.
//

import Foundation

extension UnitRect {

  public var standardised: UnitRect {
    let x0 = origin.x.magnitude
    let y0 = origin.y.magnitude
    let x1 = x0 + size.width.magnitude
    let y1 = y0 + size.height.magnitude

    let minX = min(x0, x1)
    let minY = min(y0, y1)
    let maxX = max(x0, x1)
    let maxY = max(y0, y1)

    return UnitRect(
      origin: UnitPosition(
        x: UnitLength(magnitude: minX, unitLength: origin.x.unitLength),
        y: UnitLength(magnitude: minY, unitLength: origin.y.unitLength)
      ),
      size: UnitSize(
        width: UnitLength(magnitude: maxX - minX, unitLength: size.width.unitLength),
        height: UnitLength(magnitude: maxY - minY, unitLength: size.height.unitLength)
      )
    )
  }

  /// Converts a rect and cell size into a pair of GridPositions.
  /// Always uses top-leading and bottom-trailing corners.
  public init?(
    from rect: CGRect,
    unitSize: CGSize,
    rounding: GridRounding = .down
  ) {

    let standardised = rect.standardized

    guard
      let origin = UnitPosition(
        fromCGPoint: standardised.origin,
        unitSize: unitSize,
        rounding: rounding
      ),
      let size = UnitSize(
        fromSize: standardised.size,
        unitSize: unitSize,
        rounding: rounding
      )
    else { return nil }

    self.init(origin: origin, size: size)
  }

  /// Iterates over all `GridPositions` within this `UnitRect`
  public func gridPositions() -> [GridPosition] {
    return rowRange.flatMap { row in
      colRange.map { col in
        GridPosition(column: col, row: row)
      }
    }
  }

  public func contains(_ position: GridPosition) -> Bool {
    return rowRange.contains(position.row) && colRange.contains(position.column)
  }

  private var rowRange: Range<Int> {
    let startRow = origin.y.magnitude
    let height = size.height.magnitude
    return startRow..<(startRow + height)
  }
  private var colRange: Range<Int> {
    let startCol = origin.x.magnitude
    let width = size.width.magnitude
    return startCol..<(startCol + width)
  }
}
