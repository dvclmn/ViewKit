//
//  Grid+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/11/2025.
//

import Foundation

extension GridShaped {
  
  public func unitSize(
    cellSize: CGSize
  ) -> UnitSize {
    UnitSize(dimensions: dimensions, unitSize: cellSize)
  }
  
  var rows: [Row] { cells }
  var columns: Cells {
    guard let firstRow = cells.first else { return [] }
    return (0..<firstRow.count).map { col in
      cells.map(\.self[col])
    }
  }

  /// The total number of cells in the grid, whether empty or not
  public var cellCount: Int { rowCount * columnCount }
  
  /// The total number of non-empty cells in the grid
  public var cellCountRagged: Int { cells.reduce(0) { $0 + $1.count } }
  
  public var rowCount: Int { cells.count }

  /// Width of the first row — the 'intended' width of a rectangular grid.
  /// Aka the canoncial width
  public var columnCount: Int { cells.first?.count ?? 0 }

  /// This returns the `maxWidth`(width of the widest row).
  /// Use `canonicalWidth` for width of *first* row
  public var width: Int { widestRow }

  /// Width of the widest row
  public var widestRow: Int { cells.map(\.count).max() ?? 0 }
  public var height: Int { cells.count }

  public var isEmpty: Bool {
    cells.isEmpty || cells.allSatisfy { $0.isEmpty }
  }

  public var dimensions: GridDimensions { .init(width: columnCount, height: rowCount) }

  func cells(at positions: [GridPosition]) -> [Cell] {
    var cells: [Cell] = []
    for position in positions {
      if let cell = self[at: position] {
        cells.append(cell)
      }
    }
    return cells
  }
  
//  func position(for value: Cell) -> GridPosition? {
////    let row = value.
////     let cell = self[]
//  }

  public func positions(of value: Cell) -> [GridPosition] {
    var positions: [GridPosition] = []
    for (rowIndex, line) in rows.enumerated() {
      for (columnIndex, val) in line.enumerated() where val == value {
        positions.append(GridPosition(column: columnIndex, row: rowIndex))
      }
    }
    return positions
  }

  //  func cells(in bounds: GridDimensions) -> [GridCell] {
  //    var cells: [GridCell] = []
  //    for row in 0..<bounds.height {
  //      for column in 0..<bounds.width {
  //        let position = GridPosition(row: row, column: column)
  //        if let cell = self[at: position] {
  //          cells.append(cell)
  //        }
  //      }
  //    }
  //    return cells
  //  }
}

//extension GridShaped where Cell.Value
