//
//  UnitRect+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/1/2026.
//

import Foundation

// MARK: - Convenience Initialisers
extension UnitRect {

  /// Creates a UnitRect that bounds two GridPositions inclusively
  public init(
    from a: GridPosition,
    to b: GridPosition,
    unitSize: CGSize
  ) {

    let minRow = min(a.row, b.row)
    let maxRow = max(a.row, b.row)
    let minCol = min(a.column, b.column)
    let maxCol = max(a.column, b.column)

    let origin = UnitPosition(
      x: UnitLength(magnitude: minCol, unitLength: unitSize.width),
      y: UnitLength(magnitude: minRow, unitLength: unitSize.height)
    )

    let size = UnitSize(
      width: UnitLength(
        magnitude: maxCol - minCol + 1,
        unitLength: unitSize.width
      ),
      height: UnitLength(
        magnitude: maxRow - minRow + 1,
        unitLength: unitSize.height
      )
    )

    self.init(origin: origin, size: size)
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
}

// MARK: - Helpers
extension UnitRect {

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

    let magW = maxX - minX
    let magH = maxY - minY
    
    return UnitRect(
      origin: UnitPosition(
        minX: minX,
        minY: minY,
        other: origin
      ),
      size: UnitSize(
        magnitudeA: magW,
        magnitudeB: magH,
        other: size
      )
    )
  }

}
