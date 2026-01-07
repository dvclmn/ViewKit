//
//  Model+UnitRect.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/7/2025.
//

import Foundation

public struct UnitRect: ModelBase {

  public var origin: GridPosition
  public var size: UnitSize

  public init(
    origin: GridPosition,
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
  ///
  /// Note: Due to the nature of `UnitRect`, it is permitted to create
  /// `GridPosition`(s) that lay at negative coordinates.
  /// Otherwise `UnitRect` is too restricted.
  public init(
    startPosition a: GridPosition,
    endPosition b: GridPosition,
    unitSize: CGSize
  ) {

    let minRow = min(a.row, b.row)
    let maxRow = max(a.row, b.row)
    let minCol = min(a.column, b.column)
    let maxCol = max(a.column, b.column)

    let origin = GridPosition(row: minRow, column: minCol)

    let dimensions = GridDimensions(
      width: maxCol - minCol + 1,
      height: maxRow - minRow + 1
    )

    self.init(origin: origin, dimensions: dimensions, unitSize: unitSize)
//    self.init(
//      origin: origin,
//      size: size,
//      unitSize: unitSize
//    )
  }

  public init(fromRect rect: CGRect, unitSize: CGSize) {
    let (a, b) = Self.gridPositions(from: rect, unitSize: unitSize)
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

  /// Converts a rect and cell size into a pair of GridPositions.
  /// Always uses top-leading and bottom-trailing corners.
    public static func gridPositions(
      from rect: CGRect,
      unitSize: CGSize,
      rounding: GridRounding = .down
    ) -> (GridPosition, GridPosition) {
      
      
      
//      let standardised = rect.standardized
//      let a = GridPosition(point: standardised.origin, cellSize: cellSize)
//      let b = GridPosition(point: standardised.point(for: .bottomTrailing), cellSize: cellSize)
//      let a =
//      let pointA = standardised.origin
//      let pointB = standardised.point(at: .bottomTrailing)
//      
//      let row = pointA.
//      
//      let posA = GridPosition(<#T##row: Int##Int#>, <#T##column: Int##Int#>)
      
//      return (a, b)
    }

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
  public var positions: [GridPosition] {
    (origin.row..<origin.row + size.height).flatMap { row in
      (origin.column..<origin.column + size.width).map { col in
        GridPosition(row: row, column: col)
      }
    }
  }

  public func contains(_ position: GridPosition) -> Bool {
    let rowRange = origin.row..<(origin.row + size.height)
    let colRange = origin.column..<(origin.column + size.width)
    return rowRange.contains(position.row) && colRange.contains(position.column)
  }

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
