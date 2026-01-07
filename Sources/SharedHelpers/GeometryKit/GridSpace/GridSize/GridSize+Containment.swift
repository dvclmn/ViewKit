//
//  UnitSize+Containment.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/1/2026.
//

import Foundation

extension UnitSize {
  /// Checks if a point (in pixel coordinates) falls within the grid bounds
  public func contains(point: CGPoint) -> Bool {
    //  public func contains(point: CGPoint, cellSize: CGSize) -> Bool {
    //    let gridSize = toCGSize(withCellSize: cellSize)
    return point.x >= 0
      && point.y >= 0
      && point.x < screenWidth
      && point.y < screenHeight
  }
  /// Checks if a grid position is within valid bounds
  public func contains(position: GridPosition) -> Bool {
    return position.column >= 0
      && position.row >= 0
      && position.column < width
      && position.row < height
  }

  /// Convenience method: converts point to position and checks if it's valid
//  public func containsValidPosition(for point: CGPoint) -> Bool {
//    let gridPosition = position(for: point)
//    return contains(position: gridPosition)
//  }
  
  public func position(
    for point: CGPoint,
    rounding: GridRounding = .down,
    mapping: AxisMapping = .default,
  ) -> GridPosition {
    
    let row = point.value(along: .horizontal, mapping: mapping)
    let col = point.value(along: .vertical, mapping: mapping)
    
    return GridPosition(<#T##row: Int##Int#>, <#T##column: Int##Int#>)
//    fatalError("Needs implementation after refactor of UnitSize/AxisMapping")
//    let row = convention.makeCGPoint(h: <#T##CGFloat#>, v: <#T##CGFloat#>)
//    GridPosition(
//      row: Int(floor(point.y / cellSize.height)),
//      column: Int(floor(point.x / cellSize.width)),
//    )
  }
}
