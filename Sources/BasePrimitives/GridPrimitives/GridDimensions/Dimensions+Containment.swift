//
//  Dimensions+Containment.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 20/3/2026.
//

import Foundation

extension GridDimensions {

  /// Checks if a point (in canvas/screen coordinates) falls within the grid bounds.
  public func contains(point: CGPoint, unitSize: CGSize) -> Bool {
//    guard
      let size = toScreenSize(using: unitSize)
//    else { return false }

    return point.isGreaterThanOrEqualToZero
      && point.x < size.width
      && point.y < size.height
  }

  /// Constructs a `GridRect` with origin of `zero`
  var bounds: GridRect { .init(origin: .zero, size: self) }

  public func contains(position: GridPosition) -> Bool {
    bounds.contains(position)
  }
  
  
  /// Check if this grid can fit within another grid
  public func fits(within other: GridDimensions) -> Bool {
    return self.width <= other.width && self.height <= other.height
  }

  /// Checks if a grid position is within valid bounds
  //  public func contains(position: GridPosition) -> Bool {
  //    return position.column >= 0
  //      && position.row >= 0
  //      && position.column < width
  //      && position.row < height
  //  }
  //  public func contains(position: GridPosition) -> Bool {
  //    let min = GridPosition(column: 0, row: 0)
  //
  //    /// last valid index is width-1, height-1
  //    let max = GridPosition(column: width - 1, row: height - 1)
  //    return (min...max).contains(position)
  //  }
}
