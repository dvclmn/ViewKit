//
//  Grid+CRUD.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/1/2026.
//

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

  public mutating func clearCells(at positions: [GridPosition]) {
    for position in positions where isPositionValid(position) {
      self[at: position] = Cell.createBlank()
    }
  }
  
//  public mutating func clearCells(at positions: [GridPosition]) {
//    for position in positions {
//      self[at: position] = nil
//    }
//  }

  @inlinable
  mutating func ensureRectangular(paddingCell: Cell = .createBlank()) {
    guard !cells.isEmpty else { return }
    let width = columnCount
    for i in cells.indices {
      let shortfall = width - cells[i].count
      if shortfall > 0 {
        cells[i].append(contentsOf: Array(repeating: paddingCell, count: shortfall))
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

    /// Normalize before adding columns
    ensureRectangular(paddingCell: blank())

    /// Add columns if needed
    if columnCount < requiredColumns {
      let delta = requiredColumns - columnCount
      addColumns(to: .trailing, count: delta)
    }
    //    let requiredRows = position.row + 1
    //    let requiredColumns = Swift.max(columnCount, position.column + 1)
    //
    //    var newCells: Cells = []
    //
    //    for row in 0..<requiredRows {
    //      var newRow: Row = []
    //      for column in 0..<requiredColumns {
    //        let pos = GridPosition(column: column, row: row)
    //        if let cell = self[at: pos] {
    //          newRow.append(cell)
    //        } else {
    //          newRow.append(blank())
    //        }
    //      }
    //      newCells.append(newRow)
    //    }
    //    self.cells = newCells
  }

  mutating func addColumns(to edge: GridEdge, count: Int = 1) {
    for _ in 0..<count { addColumn(to: edge) }
  }

  mutating func removeColumns(from edge: GridEdge, count: Int = 1) {
    precondition(columnCount > count, "Cannot remove \(count) columns; only \(columnCount) available")
    for _ in 0..<count { removeColumn(from: edge) }
  }

  mutating func addRows(to edge: GridEdge, count: Int = 1) {
    for _ in 0..<count { addRow(to: edge) }
  }

  mutating func removeRows(from edge: GridEdge, count: Int = 1) {
    precondition(rowCount > count, "Cannot remove \(count) rows; only \(rowCount) available")
    for _ in 0..<count { removeRow(from: edge) }
  }

  public mutating func addRow(to edge: GridEdge) {
    switch edge {
      case .top:
        let newRow: Row = (0..<columnCount).map { _ in .createBlank() }
        cells.insert(newRow, at: 0)
      case .bottom:
        let newRow: Row = (0..<columnCount).map { _ in .createBlank() }
        cells.append(newRow)
      default:
        break
    }
  }

  public mutating func removeRow(from edge: GridEdge) {
    precondition(rowCount > 1, "Cannot remove last row")
    switch edge {
      case .top: cells.removeFirst()
      case .bottom: cells.removeLast()
      default: preconditionFailure("Invalid edge for row removal")
    }
  }

  public mutating func addColumn(to edge: GridEdge) {
    precondition(edge.isColumnEdge)
    ensureRectangular()
    for rowIndex in cells.indices {
      if edge == .leading {
        cells[rowIndex].insert(.createBlank(), at: 0)
      } else {
        cells[rowIndex].append(.createBlank())
      }
    }
  }

  public mutating func removeColumn(from edge: GridEdge) {
    precondition(columnCount > 1, "Cannot remove last column")
    ensureRectangular()
    let targetColumn = (edge == .leading) ? 0 : columnCount - 1
    for rowIndex in cells.indices {
      cells[rowIndex].remove(at: targetColumn)
    }
  }

  //#warning("Have changed approach regarding GridPosition, no longer stored on GridCell, so will need to fix this up")
  //  public mutating func addRow(to edge: GridEdge) {
  //    switch edge {
  //      case .top:
  //        let newRow: Row = (0..<columnCount).map { _ in Cell.createBlank() }
  //        cells.insert(newRow, at: 0)
  //      //        rows += 1
  //      //        reindexPositions()
  //
  //      case .bottom:
  //        let newRow: Row = (0..<columnCount).map { _ in Cell.createBlank() }
  //        cells.append(newRow)
  //      //        rows += 1
  //      //        reindexPositions()
  //
  //      default:
  //        break  // handled elsewhere
  //    }
  //  }
  //
  //  //#warning("Have changed approach regarding GridPosition, no longer stored on GridCell, so will need to fix this up")
  //  public mutating func removeRow(from edge: GridEdge) {
  //    precondition(rowCount > 1, "Cannot remove last row")
  //
  //    switch edge {
  //      case .top:
  //        cells.removeFirst()
  //      case .bottom:
  //        cells.removeLast()
  //      default:
  //        fatalError("Invalid edge for row removal")
  //    }
  //  }

  //  public mutating func addColumn(to edge: GridEdge) {
  //    precondition(edge == .leading || edge == .trailing)
  //
  //    for rowIndex in 0..<rowCount {
  //      if edge == .leading {
  //        cells[rowIndex].insert(Cell.createBlank(), at: 0)
  //      } else {
  //        cells[rowIndex].append(Cell.createBlank())
  //      }
  //    }
  //
  //    //    columns += 1
  //    //    reindexPositions()
  //  }
  //
  //  #warning(
  //    "Have changed approach regarding GridPosition, no longer stored on GridCell, so will need to fix this up")
  //
  //  public mutating func removeColumn(from edge: GridEdge) {
  //    precondition(columnCount > 1, "Cannot remove last column")
  //
  //    let targetColumn = (edge == .leading) ? 0 : columnCount - 1
  //
  //    for rowIndex in 0..<rowCount {
  //      cells[rowIndex].remove(at: targetColumn)
  //    }
  //
  //    //    columns -= 1
  //    //    reindexPositions()
  //  }
}
