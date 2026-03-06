//
//  Grid+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/11/2025.
//

import Foundation

extension GridShaped {

  public func canvasSize(
    cellSize: CGSize
  ) -> CGSize? {
    dimensions.toScreenSize(using: cellSize)
  }

//  var rows: [Row] { cells }

  /// Uses width of the widest row to derive columns
  var columns: Rows {
    let maxCount = widestRow
    guard maxCount > 0 else { return [] }
    return (0..<maxCount).map { col in
      rows.compactMap { row in
        row[safe: col]
      }
    }
    //    guard let firstRow = cells.first else { return [] }
    //    return (0..<firstRow.count).map { col in
    //      cells.compactMap { row in
    //        row[safe: col]
    //      }
    //    }
  }

  /// The total number of cells in the grid, whether empty or not
  public var cellCount: Int { Swift.max(0, rowCount * width) }

  /// The total number of non-empty cells in the grid
  public var cellCountRagged: Int { rows.reduce(0) { $0 + $1.count } }

  public var rowCount: Int { rows.count }
  public var height: Int { rowCount }

  /// This returns the width of the widest row. ``widestRow``
  public var columnCount: Int { widestRow }
  public var width: Int { widestRow }
  public var widestRow: Int { rows.map(\.count).max() ?? 0 }

  /// Width of the first non-empty row
  public var canonicalColumnCount: Int {
    rows.first(where: { !$0.isEmpty })?.count ?? 0
  }

  public var isEmpty: Bool {
    rows.isEmpty || rows.allSatisfy { $0.isEmpty }
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

  public var dimensions: GridDimensions {
    .init(
      width: width,
      height: rowCount
    )
  }

}
