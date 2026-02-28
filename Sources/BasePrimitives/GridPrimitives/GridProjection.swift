//
//  GridProjection.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 28/2/2026.
//

import Foundation

/// Bridges the gap between pure Grid dimensions and Canvas (continuous) space.
public struct GridProjection {
  
  /// The size of a single grid cell in Canvas Space.
  public var cellSize: CGSize
  public var rounding: GridRounding = .down
  
  public init(cellSize: CGSize) {
    self.cellSize = cellSize
  }
  
  // MARK: - Grid to Canvas (Up the chain)
  
  public func canvasSize(for dimensions: GridDimensions) -> CGSize {
    CGSize(
      width: CGFloat(dimensions.width) * cellSize.width,
      height: CGFloat(dimensions.height) * cellSize.height
    )
  }
  
  public func canvasPoint(for gridPoint: GridPoint) -> CGPoint {
    CGPoint(
      x: CGFloat(gridPoint.x) * cellSize.width,
      y: CGFloat(gridPoint.y) * cellSize.height
    )
  }
  
  // MARK: - Canvas to Grid (Down the chain)
  
  public func gridDimensions(for canvasSize: CGSize) -> GridDimensions {
    // Here you would implement your specific rounding logic
    GridDimensions(
      width: Int(canvasSize.width / cellSize.width), // Simplified
      height: Int(canvasSize.height / cellSize.height)
    )
  }
  
  public func gridPoint(for canvasPoint: CGPoint) -> GridPoint {
    GridPoint(
      x: Int(canvasPoint.x / cellSize.width),
      y: Int(canvasPoint.y / cellSize.height)
    )
  }
}
