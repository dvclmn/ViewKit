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
      cells.compactMap { row in
        row[safe: col]
      }
    }
  }

  /// The total number of cells in the grid, whether empty or not
  public var cellCount: Int { rowCount * columnCount }

  /// The total number of non-empty cells in the grid
  public var cellCountRagged: Int { cells.reduce(0) { $0 + $1.count } }

  public var rowCount: Int { cells.count }

  /// Width of the **first row** — the 'intended' width of a rectangular grid.
  /// Aka the canoncial width
  public var columnCount: Int { cells.first?.count ?? 0 }

  /// This returns the `maxWidth`(width of the widest row).
  /// Use `canonicalWidth` for width of **first** row
  public var width: Int { widestRow }

  /// Width of the widest row
  public var widestRow: Int { cells.map(\.count).max() ?? 0 }
  public var height: Int { cells.count }

  public var isEmpty: Bool {
    cells.isEmpty || cells.allSatisfy { $0.isEmpty }
  }

  public func forEachPosition(_ body: (GridPosition, Cell) -> Void) {
    for (r, row) in rows.enumerated() {
      for (c, cell) in row.enumerated() {
        body(GridPosition(column: c, row: r), cell)
      }
    }
  }

  public func positions(of value: Cell) -> [GridPosition] {
    var result: [GridPosition] = []
    forEachPosition { pos, cell in
      if cell == value { result.append(pos) }
    }
    return result
  }

  public func cells(at positions: [GridPosition]) -> [Cell] {
    positions.compactMap { self[at: $0] }
  }

  public var dimensions: GridDimensions { .init(width: columnCount, height: rowCount) }

}
