//
//  Dimensions+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 18/12/2025.
//

import Foundation

// MARK: - Containment Methods
extension GridDimensions {

  public var doubled: GridDimensions {
    GridDimensions(width: width * 2, height: height * 2)
  }
  
  private func toUnitSize(with unitSize: CGSize) -> UnitSize {
    UnitSize(width: width, height: height, unitSize: unitSize)
  }

  /// These have moved to UnitSize.
  /// Checks if a point (in pixel coordinates) falls within the grid bounds
  public func contains(
    point: CGPoint,
    unitSize: CGSize
  ) -> Bool {
    let size = toUnitSize(with:)
    //  public func contains(point: CGPoint, cellSize: CGSize) -> Bool {
    //    let gridSize = toCGSize(withCellSize: cellSize)
    return point.x >= 0
      && point.y >= 0
      && point.x < screenWidth(using: unitSize)
      && point.y < screenHeight(using: unitSize)
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

//  public func position(
//    for point: CGPoint,
//    rounding: GridRounding = .down,
//    mapping: AxisMapping = .default,
//  ) -> GridPosition {
//
//    let row = point.value(along: .horizontal, mapping: mapping)
//    let col = point.value(along: .vertical, mapping: mapping)
//
//    return GridPosition(<#T##row: Int##Int#>, <#T##column: Int##Int#>)
//    //    fatalError("Needs implementation after refactor of UnitSize/AxisMapping")
//    //    let row = convention.makeCGPoint(h: <#T##CGFloat#>, v: <#T##CGFloat#>)
//    //    GridPosition(
//    //      row: Int(floor(point.y / cellSize.height)),
//    //      column: Int(floor(point.x / cellSize.width)),
//    //    )
//  }
}

// MARK: - Coordinate Conversion
extension GridDimensions {

}

// MARK: - Size Calculations
extension GridDimensions {
//  public func screenWidth(using unitSize: CGSize) -> CGFloat {
//    toUnitSize(with: unitSize).screenWidth
//  }
//
//  public func screenHeight(using unitSize: CGSize) -> CGFloat {
//    toUnitSize(with: unitSize).screenHeight
//  }
//
//  public func screenSize(using unitSize: CGSize) -> CGSize {
//    toUnitSize(with: unitSize).screenSize
//  }

  //  public func width(with cellSize: CGSize) -> CGFloat {
  //    CGFloat(width) * cellSize.width
  //  }
  //
  //  public func height(with cellSize: CGSize) -> CGFloat {
  //    CGFloat(height) * cellSize.height
  //  }

  //  public func toCGSize(withCellSize cellSize: CGSize) -> CGSize {
  //    CGSize(
  //      width: width(with: cellSize),
  //      height: height(with: cellSize)
  //    )
  //  }
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
    return GridPosition(row: height - 1, column: width - 1)
  }

  public func reducedToFit(within bounds: GridDimensions) -> GridDimensions? {
    let cols = min(self.width, bounds.width)
    let rows = min(self.height, bounds.height)
    guard cols > 0, rows > 0 else { return nil }
    return GridDimensions(width: cols, height: rows)
  }

}
