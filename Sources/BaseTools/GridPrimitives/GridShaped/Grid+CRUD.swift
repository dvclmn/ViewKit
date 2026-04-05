//
//  Grid+CRUD.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/1/2026.
//

public enum ClearStrategy {
  case assignBlank  // default
  case compactTrailingBlanksAfterClear  // assign blank, then compact
  case removeIfTrailingOnly  // structural removal only if it’s the trailing element of that row
}

extension GridShaped {
  public mutating func clearCells(
    at positions: [GridPosition],
    strategy: ClearStrategy = .assignBlank,
    blank: @autoclosure () -> Cell
  ) {
    for pos in positions where isPositionValid(pos) {
      if pos.column < rows[pos.row].count {
        rows[pos.row][pos.column] = blank()
      } else {
        // Inside bounding box but beyond row length: nothing to write,
        // reads will still see blank via `cell(at:)`
      }
    }

    switch strategy {
      case .assignBlank:
        break
      case .compactTrailingBlanksAfterClear:
        compactTrailingBlanks(isBlank: { $0 == blank() })
      case .removeIfTrailingOnly:
        for pos in positions where isRowValid(pos.row) {
          var row = rows[pos.row]
          if pos.column == row.count - 1 {
            row.removeLast()
            rows[pos.row] = row
          } else if pos.column < row.count {
            rows[pos.row][pos.column] = blank()
          }
        }
    }
  }

  public mutating func compactTrailingBlanks(isBlank: (Cell) -> Bool) {
    for i in rows.indices {
      var row = rows[i]
      while let last = row.last, isBlank(last) {
        row.removeLast()
      }
      rows[i] = row
    }
    // Optionally drop trailing empty rows:
    while let last = rows.last, last.isEmpty {
      rows.removeLast()
    }
  }
}

/// Notes after moving away from *stored* `GridPosition`s
/// on cells, to *derived* positions.
///
///
extension GridShaped {

  /// When a user starts drawing in previously empty space:
  public mutating func set(_ value: Cell, at position: GridPosition) {
    expandToInclude(position: position, blank: Cell.createBlank())
    self[at: position] = value
  }

  //  // TODO: Possibly provide option for either optional or blank?
  //  public mutating func clearCells(at positions: [GridPosition]) {
  //    for position in positions where isPositionValid(position) {
  //      self[at: position] = Cell.createBlank()
  //    }
  //  }

  /// Empty grid + addColumn is currently a no-op.
  /// Need to decide whether this should create a 1-row grid.
  /// If yes, codify it (e.g., if row​Count == 0 and add​Column is called, insert a single empty row first).
  /// Ensures that each row has `width` columns by appending `paddingCell` as needed.
  /// - Note: If `paddingCell` construction is non-trivial, consider passing a lazily-created
  ///   value from the caller only when padding is required. This function does not evaluate
  ///   anything itself beyond using the provided value when padding occurs.
  @inlinable
  mutating func ensureRectangular(paddingCell: Cell = .createBlank()) {
    guard !rows.isEmpty else { return }
    for i in rows.indices {
      let shortfall = width - rows[i].count
      if shortfall > 0 {
        rows[i].append(contentsOf: Array(repeating: paddingCell, count: shortfall))
      }
    }
  }

  // TODO: Need to separate inherent dimensions from user-defined 'frame'
  public mutating func expandToInclude(
    position: GridPosition,
    blank: @autoclosure () -> Cell
  ) {
    /// No-op if already valid
    if isPositionValid(position) { return }

    let requiredRows = position.row + 1
    let requiredColumns = position.column + 1

    /// Add rows if needed
    if rowCount < requiredRows {
      let delta = requiredRows - rowCount
      addRows(to: .bottom, count: delta)
    }

    // Normalize before adding columns only if there is a shortfall in any row
    if rows.contains(where: { $0.count < width }) {
      // Evaluate blank() only when we actually need padding
      ensureRectangular(paddingCell: blank())
    }

    /// Add columns if needed
    if width < requiredColumns {
      let delta = requiredColumns - width
      addColumns(to: .trailing, count: delta)
    }
  }
}

// MARK: - Add
extension GridShaped {

  mutating func addRows(to edge: GridEdge, count: Int = 1) {
    for _ in 0..<count { addRow(to: edge) }
  }

  public mutating func addRow(to edge: GridEdge) {
    // Ensure grid is rectangular so "width" reflects intended column count
    ensureRectangular()
    let newRow: Row = (0..<width).map { _ in .createBlank() }
    switch edge {
      case .top:
        rows.insert(newRow, at: 0)
      case .bottom:
        rows.append(newRow)
      default:
        break
    }
  }

  mutating func addColumns(to edge: GridEdge, count: Int = 1) {
    for _ in 0..<count { addColumn(to: edge) }
  }

  /// Empty grid + addColumn is currently a no-op — see comment on
  /// `ensureRectangular()`
  public mutating func addColumn(to edge: GridEdge) {
    precondition(edge.isColumnEdge)
    ensureRectangular()
    for rowIndex in rows.indices {
      if edge == .leading {
        rows[rowIndex].insert(.createBlank(), at: 0)
      } else {
        rows[rowIndex].append(.createBlank())
      }
    }
  }

}

// MARK: - Remove
extension GridShaped {

  mutating func removeRows(from edge: GridEdge, count: Int = 1) {
    precondition(count >= 0, "Count must be non-negative")
    precondition(rowCount - count >= 1, "Cannot remove \(count) rows; must leave at least one row (currently \(rowCount))")
    for _ in 0..<count { removeRow(from: edge) }
  }

  public mutating func removeRow(from edge: GridEdge) {
    precondition(rowCount > 1, "Cannot remove last row")
    switch edge {
      case .top: rows.removeFirst()
      case .bottom: rows.removeLast()
      default: preconditionFailure("Invalid edge for row removal")
    }
  }

  mutating func removeColumns(from edge: GridEdge, count: Int = 1) {
    precondition(count >= 0, "Count must be non-negative")
    precondition(width - count >= 1, "Cannot remove \(count) columns; must leave at least one column (currently \(width))")
    for _ in 0..<count { removeColumn(from: edge) }
  }

  public mutating func removeColumn(from edge: GridEdge) {
    precondition(width > 1, "Cannot remove last column")
    ensureRectangular()
    let targetColumn = (edge == .leading) ? 0 : width - 1
    for rowIndex in rows.indices {
      rows[rowIndex].remove(at: targetColumn)
    }
  }
}

