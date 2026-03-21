//
//  Dimensions+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/12/2025.
//

import Foundation

extension GridDimensions {
  public static var zero: GridDimensions { .init(width: 0, height: 0) }
  public var doubled: GridDimensions { self * 2 }

  /// Total number of cells in the grid
  public var cellCount: Int { width * height }

  /// All valid positions in the grid
  public var allPositions: [GridPosition] {
    (0..<height).flatMap { row in
      (0..<width).map { column in
        GridPosition(column: column, row: row)
      }
    }
  }

  /// Aka last valid index. Will return `zero` if width or height
  /// are not greater than zero.
  public var bottomRight: GridPosition {
    //    guard width > 0, height > 0 else { return nil }
    return GridPosition(
      column: max(0, width - 1),
      row: max(0, height - 1)
    )
  }

  public func reducedToFit(within bounds: GridDimensions) -> GridDimensions? {
    let cols = min(self.width, bounds.width)
    let rows = min(self.height, bounds.height)
    guard cols > 0, rows > 0 else { return nil }
    return GridDimensions(width: cols, height: rows)
  }

  //  public static let minSize = GridDimensions(
  //    width: minCellsAlongLength,
  //    height: minCellsAlongLength
  //  )
  //  public static let maxSize = GridDimensions(
  //    width: maxCellsAlongLength,
  //    height: maxCellsAlongLength
  //  )
  //
  //  public static let maxCellsAlongLength: Int = 90_000
  //  public static let minCellsAlongLength: Int = 1
  //
  //  public var respectsMaxCells: Bool {
  //    return self.bothLessThan(rhs: Self.maxCellsAlongLength)
  //  }
  //  public var respectsMinCells: Bool {
  //    return self.bothGreaterThan(rhs: Self.minCellsAlongLength)
  //  }

}

