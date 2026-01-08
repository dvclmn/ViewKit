//
//  Model+UnitRect.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/7/2025.
//

import Foundation

public struct UnitRect: ModelBase {

  public var origin: UnitPosition
  public var size: UnitSize

  public init(
    origin: UnitPosition,
    size: UnitSize,
  ) {
    self.origin = origin
    self.size = size
  }

  public init(
    origin: GridPosition,
    dimensions: GridDimensions,
    unitSize: CGSize
  ) {
    self.origin = origin
    let unitSize = UnitSize(
      width: dimensions.width,
      height: dimensions.height,
      unitSize: unitSize
    )
    self.size = unitSize
  }

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
      x: UnitLength(count: minCol, unitLength: unitSize.width),
      y: UnitLength(count: minRow, unitLength: unitSize.height)
    )

    let size = UnitSize(
      width: UnitLength(
        count: maxCol - minCol + 1,
        unitLength: unitSize.width
      ),
      height: UnitLength(
        count: maxRow - minRow + 1,
        unitLength: unitSize.height
      )
    )

    self.init(origin: origin, size: size)
  }

  public init(
    fromRect rect: CGRect,
    unitSize: CGSize,
    rounding: GridRounding = .down,
  ) {

    let standardisedRect = rect.standardized
    let unitSize = standardisedRect.size.toUnitSize(using: unitSize, rounding: rounding)

    //    let (a, b) = Self.gridPositions(from: rect, unitSize: unitSize)
    self.init(startPosition: a, endPosition: b, unitSize: unitSize)
  }

  //  public init(
  //    fromRect rect: CGRect,
  //    cellSize: CGSize,
  //    //    clampedTo bounds: GridDimensions? = nil
  //  ) {
  //    /// Standardise the rect, so origin is always top-left
  //    let standardisedRect = rect.standardized
  //
  //    let origin =
  //      GridPosition(
  //        point: standardisedRect.origin,
  //        cellSize: cellSize,
  //      )
  //
  //    let endPosition = GridPosition(
  //      point: standardisedRect.point(for: .bottomTrailing),
  //      cellSize: cellSize,
  //    )
  //
  //    self.init(
  //      boundingPositions: origin,
  //      endPosition,
  //      cellSize: cellSize
  //    )
  //  }
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
  //    public static func gridPositions(
  //      from rect: CGRect,
  //      unitSize: CGSize,
  //      rounding: GridRounding = .down
  //    ) -> (GridPosition, GridPosition) {
  //
  //      let unitRect = UnitRect(fromRect: <#T##CGRect#>, unitSize: <#T##CGSize#>)
  //
  //
  ////      let standardised = rect.standardized
  ////      let a = GridPosition(point: standardised.origin, cellSize: cellSize)
  ////      let b = GridPosition(point: standardised.point(for: .bottomTrailing), cellSize: cellSize)
  ////      let a =
  ////      let pointA = standardised.origin
  ////      let pointB = standardised.point(at: .bottomTrailing)
  ////
  ////      let row = pointA.
  ////
  ////      let posA = GridPosition(<#T##row: Int##Int#>, <#T##column: Int##Int#>)
  //
  ////      return (a, b)
  //    }

  /// Same as `gridPositions(from:)` but returns nil if either position
  /// falls outside of bounds.
  public static func gridPositionsIfContained(
    in bounds: GridDimensions,
    from rect: CGRect,
    cellSize: CGSize
  ) -> (GridPosition, GridPosition)? {
    let standardised = rect.standardized
    guard
      let a = GridPosition.createIfContained(within: bounds, at: standardised.origin, cellSize: cellSize),
      let b = GridPosition.createIfContained(
        within: bounds, at: standardised.point(for: .bottomTrailing), cellSize: cellSize)
    else {
      return nil
    }
    return (a, b)
  }

  /// Iterates over all GridPositions within this UnitRect
 



  public var toCGRect: CGRect {
    let originPoint = origin.toCGPoint(cellSize: cellSize)
    //    let size = CGSize(
    //      width: CGFloat(self.size.width) * cellSize.width,
    //      height: CGFloat(self.size.height) * cellSize.height
    //    )
    return CGRect(origin: originPoint, size: size)
  }

  //  public func toCGRect(cellSize: CGSize) -> CGRect {
  //    let originPoint = origin.toCGPoint(cellSize: cellSize)
  //    let size = CGSize(
  //      width: CGFloat(self.size.columns) * cellSize.width,
  //      height: CGFloat(self.size.rows) * cellSize.height
  //    )
  //    return CGRect(origin: originPoint, size: size)
  //  }

  //  public static func create(clampedTo bounds: GridDimensions) -> UnitRect {
  //
  //  }

  public static func createIfContained(
    within bounds: GridDimensions,
    fromRect rect: CGRect,
    cellSize: CGSize
  ) -> Self? {
    guard let (a, b) = gridPositionsIfContained(in: bounds, from: rect, cellSize: cellSize)
    else { return nil }

    return UnitRect(startPosition: a, endPosition: b, cellSize: cellSize)
  }

}
