//
//  Dimensions+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/12/2025.
//

import Foundation


// MARK: - Size Calculations
extension GridDimensions {
  public var doubled: GridDimensions { self * 2 }

  public func toScreenSize(using unitSize: CGSize) -> CGSize? {
    guard
      let width = width.toScreenLength(using: unitSize.width),
      let height = height.toScreenLength(using: unitSize.height)
    else { return nil }

    return CGSize(width: width, height: height)
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
    return GridPosition(column: width - 1, row: height - 1)
  }

  public func reducedToFit(within bounds: GridDimensions) -> GridDimensions? {
    let cols = min(self.width, bounds.width)
    let rows = min(self.height, bounds.height)
    guard cols > 0, rows > 0 else { return nil }
    return GridDimensions(width: cols, height: rows)
  }

}
