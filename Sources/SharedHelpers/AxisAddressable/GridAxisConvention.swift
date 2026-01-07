//
//  GridAxisConvention.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/1/2026.
//

/// This exists alongside `AxisConvention`, to represent index
/// space, where `AxisConvention` represents 'dimension' space
///
/// In a standard grid, Columns represent the horizontal index (X)
/// and Rows represent the vertical index (Y)
public enum GridAxisConvention {
  case columnIsHorizontal
  case rowIsHorizontal
}

extension GridAxisConvention {

  public var rowAxis: Axis2D {
    switch self {
      case .columnIsHorizontal: .vertical
      case .rowIsHorizontal: .horizontal
    }
  }

  public var columnAxis: Axis2D {
    switch self {
      case .columnIsHorizontal: .horizontal
      case .rowIsHorizontal: .vertical
    }
  }
}

extension GridAxisConvention {

  /// Returns the horizontal index (usually column) based on the convention.
  public func horizontalValue(for position: GridPosition) -> Int {
    switch self {
      case .columnIsHorizontal: position.column
      case .rowIsHorizontal: position.row
    }
  }

  /// Returns the vertical index (usually row) based on the convention.
  public func verticalValue(for position: GridPosition) -> Int {
    switch self {
      case .columnIsHorizontal: position.row
      case .rowIsHorizontal: position.column
    }
  }

  /// Creates a GridPosition by mapping horizontal/vertical inputs to row/column storage.
  public func makeGridPosition(h: Int, v: Int) -> GridPosition {
    switch self {
      case .columnIsHorizontal: GridPosition(row: v, column: h)
      case .rowIsHorizontal: GridPosition(row: h, column: v)
    }
  }

  // MARK: - GridSize

  /// Returns the horizontal length from a size, according to the convention.
  public func horizontalLength(gridSize: GridSize) -> GridLength {
    switch self {
      case .columnIsHorizontal: gridSize.columns
      case .rowIsHorizontal: gridSize.rows
    }
  }

  /// Returns the vertical length from a size, according to the convention.
  public func verticalLength(gridSize: GridSize) -> GridLength {
    switch self {
      case .columnIsHorizontal: gridSize.rows
      case .rowIsHorizontal: gridSize.columns
    }
  }

  /// Creates a `CGPoint` by mapping horizontal/vertical inputs to x/y storage.
  public func makeGridSize(h: GridLength, v: GridLength) -> GridSize {
    switch self {
      case .columnIsHorizontal:
        return GridSize(columns: h, rows: v)

      case .rowIsHorizontal:
        return GridSize(columns: v, rows: h)

    }
  }
}
