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

  //  public init(
  //    origin: GridPosition,
  //    dimensions: GridDimensions,
  //    unitSize: CGSize
  //  ) {
  //    self.origin = origin
  //    let unitSize = UnitSize(
  //      width: dimensions.width,
  //      height: dimensions.height,
  //      unitSize: unitSize
  //    )
  //    self.size = unitSize
  //  }

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
  //  public static func gridPositionsIfContained(
  //    in bounds: GridDimensions,
  //    from rect: CGRect,
  //    cellSize: CGSize
  //  ) -> (GridPosition, GridPosition)? {
  //    let standardised = rect.standardized
  //    guard
  //      let a = GridPosition.createIfContained(within: bounds, at: standardised.origin, cellSize: cellSize),
  //      let b = GridPosition.createIfContained(
  //        within: bounds, at: standardised.point(for: .bottomTrailing), cellSize: cellSize)
  //    else {
  //      return nil
  //    }
  //    return (a, b)
  //  }

  /// Iterates over all GridPositions within this UnitRect

  public var toCGRect: CGRect? {
    guard let originPoint = origin.toCGPoint,
      let rectSize = size.screenSize
    else { return nil }
    //    let originPoint = origin.toCGPoint(cellSize: cellSize)
    //    let size = CGSize(
    //      width: CGFloat(self.size.width) * cellSize.width,
    //      height: CGFloat(self.size.height) * cellSize.height
    //    )
    return CGRect(origin: originPoint, size: rectSize)
  }

  //  public static func create(clampedTo bounds: GridDimensions) -> UnitRect {
  //
  //  }

//  public static func createIfContained(
//    within bounds: GridDimensions,
//    fromRect rect: CGRect,
//    cellSize: CGSize
//  ) -> Self? {
//    guard let (a, b) = gridPositionsIfContained(in: bounds, from: rect, cellSize: cellSize)
//    else { return nil }
//
//    return UnitRect(startPosition: a, endPosition: b, cellSize: cellSize)
//  }

}
