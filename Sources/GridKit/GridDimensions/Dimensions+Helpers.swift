//
//  Dimensions+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/12/2025.
//

import Foundation

// MARK: - Containment Methods
extension GridDimensions {
  /// Checks if a point (in pixel coordinates) falls within the grid bounds
  public func contains(point: CGPoint, cellSize: CGSize) -> Bool {
    let gridSize = toCGSize(withCellSize: cellSize)
    return point.x >= 0
    && point.y >= 0
    && point.x < gridSize.width
    && point.y < gridSize.height
  }
  
  /// Checks if a grid position is within valid bounds
  public func contains(position: GridPosition) -> Bool {
    return position.column >= 0 && position.column < width && position.row >= 0 && position.row < height
  }
  
  /// Convenience method: converts point to position and checks if it's valid
  public func containsValidPosition(for point: CGPoint, cellSize: CGSize) -> Bool {
    let gridPosition = position(for: point, cellSize: cellSize)
    return contains(position: gridPosition)
  }
}


// MARK: - Coordinate Conversion
extension GridDimensions {
  public func position(for point: CGPoint, cellSize: CGSize) -> GridPosition {
    GridPosition(
      column: Int(floor(point.x / cellSize.width)),
      row: Int(floor(point.y / cellSize.height))
    )
  }
}

// MARK: - Size Calculations
extension GridDimensions {
  public func width(with cellSize: CGSize) -> CGFloat {
    CGFloat(width) * cellSize.width
  }
  
  public func height(with cellSize: CGSize) -> CGFloat {
    CGFloat(height) * cellSize.height
  }
  
  public func toCGSize(withCellSize cellSize: CGSize) -> CGSize {
    CGSize(
      width: width(with: cellSize),
      height: height(with: cellSize)
    )
  }
}

// MARK: - Additional Convenience Methods
extension GridDimensions {
  /// Total number of cells in the grid
  public var cellCount: Int {
    width * height
  }
  
  /// All valid positions in the grid
  public var allPositions: [GridPosition] {
    (0..<height).flatMap { row in
      (0..<width).map { column in
        GridPosition(column: column, row: row)
      }
    }
  }
  
  /// Check if this grid can fit within another grid
  public func fits(within other: GridDimensions) -> Bool {
    return self.width <= other.width && self.height <= other.height
  }
}


extension GridDimensions {
  
  public static let minSize = GridDimensions(
    columns: minCellsAlongLength,
    rows: minCellsAlongLength
  )
  public static let maxSize = GridDimensions(
    columns: maxCellsAlongLength,
    rows: maxCellsAlongLength
  )
  
  public static let maxCellsAlongLength: Int = 90_000
  public static let minCellsAlongLength: Int = 1
  
  public var respectsMaxCells: Bool {
    return self.bothLessThan(rhs: Self.maxCellsAlongLength)
  }
  public var respectsMinCells: Bool {
    return self.bothGreaterThan(rhs: Self.minCellsAlongLength)
  }
  
  public var bottomRight: GridPosition? {
    guard columns > 0, rows > 0 else { return nil }
    return GridPosition(column: columns - 1, row: rows - 1)
  }
  
  public func reducedToFit(within bounds: GridDimensions) -> GridDimensions? {
    let cols = min(self.columns, bounds.columns)
    let rows = min(self.rows, bounds.rows)
    guard cols > 0, rows > 0 else { return nil }
    return GridDimensions(columns: cols, rows: rows)
  }
  
  
}
