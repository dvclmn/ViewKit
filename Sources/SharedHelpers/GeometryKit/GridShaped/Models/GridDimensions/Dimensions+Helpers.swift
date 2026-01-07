//
//  Dimensions+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/12/2025.
//

import Foundation

// MARK: - Containment Methods
extension GridDimensions {
  
  /// These have moved to GridSize.

}


// MARK: - Coordinate Conversion
extension GridDimensions {
  
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
        GridPosition(row: row, column: column)
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
    width: minCellsAlongLength,
    height: minCellsAlongLength
  )
  public static let maxSize = GridDimensions(
    width: maxCellsAlongLength,
    height: maxCellsAlongLength
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
    guard width > 0, height > 0 else { return nil }
    return GridPosition(row: height - 1, column: width - 1)
  }
  
  public func reducedToFit(within bounds: GridDimensions) -> GridDimensions? {
    let cols = min(self.width, bounds.width)
    let rows = min(self.height, bounds.height)
    guard cols > 0, rows > 0 else { return nil }
    return GridDimensions(width: cols, height: rows)
  }
  
  
}
