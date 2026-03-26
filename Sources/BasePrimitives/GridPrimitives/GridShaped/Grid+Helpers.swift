//
//  Grid+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/11/2025.
//

import Foundation

extension GridShaped {

  /// Uses width of the widest row to derive columns.
  /// - Important: For ragged grids, this returns only existing cells.
  ///   Short rows that don't have a value at `col` are skipped (via `compactMap`).
  ///   As a result, `columns[col].count` can be less than `rowCount`.
  ///   If you need rectangular semantics (every column has `rowCount` entries),
  ///   consider padding first with `ensureRectangular()` or mapping missing values to `.createBlank()`.
  var columns: Rows {
    let maxCount = widestRow
    guard maxCount > 0 else { return [] }
    return (0..<maxCount).map { col in
      rows.compactMap { row in
        row[safe: col]
      }
    }
  }

  /// The cell at this position, or a blank if the position
  /// is within the bounding box but the row is too short.
  /// Returns nil if the position is outside the bounding box.
  public func cell(at position: GridPosition) -> Cell? {
    guard position.row >= 0, position.row < rowCount,
      position.column >= 0, position.column < widestRow
    else { return nil }
    return rows[position.row][safe: position.column] ?? .createBlank()
  }

  /// Returns nil only when outside the bounding box; otherwise
  /// returns a concrete value (blank or actual).
  //  public func cellOrBlank(at position: GridPosition) -> Cell? {
  //
  //  }

  /// Bounding box — works for ragged or rectangular
  public var boundingWidth: Int { widestRow }
  public var boundingHeight: Int { rowCount }

  /// The total number of cells in the grid's bounding rectangle (rowCount * width).
  /// For ragged grids, this may exceed the actual number of stored cells.
  public var boundingCellCount: Int { Swift.max(0, rowCount * width) }

  /// The total number of cells in the grid's bounding rectangle (rowCount * width).
  /// - Deprecated: Use `boundingCellCount` instead. For the actual stored cell count on ragged grids,
  ///   use `cellCountRagged`.
  @available(*, deprecated, renamed: "boundingCellCount")
  public var cellCount: Int { boundingCellCount }

  /// The total number of non-empty cells in the grid
  public var cellCountRagged: Int { rows.reduce(0) { $0 + $1.count } }

  public var rowCount: Int { rows.count }
  public var height: Int { rowCount }

  //  public var columnCount: Int { widestRow }
  /// This returns the width of the widest row. ``widestRow``
  public var width: Int { widestRow }
  public var widestRow: Int { rows.map(\.count).max() ?? 0 }
  public var hasBoundingBox: Bool { rowCount > 0 || widestRow > 0 }

  /// Width of the first non-empty row
  //  public var canonicalColumnCount: Int {
  //    rows.first(where: { !$0.isEmpty })?.count ?? 0
  //  }

  public var isEmpty: Bool {
    /// Previous method was ambiguous:
    //    rows.isEmpty || rows.allSatisfy { $0.isEmpty }
    cellCountRagged == 0
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
  public var size: GridDimensions { dimensions }

}
