//
//  Grid+CRUD.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/1/2026.
//

extension GridShaped {

  /// When a user starts drawing in previously empty space:
  public mutating func set(_ value: Cell, at position: GridPosition) {
    expandToInclude(position: position, blank: Cell.createBlank())
    //    expandToInclude(position: position, blank: GridCell.createBlank(at: position))
    self[at: position] = value
    //    self[at: position] = GridCell(character: char, position: position)
  }

  public mutating func clearCells(at positions: [GridPosition]) {
    for position in positions {
      self[at: position] = nil
    }
  }

  public mutating func expandToInclude(
    position: GridPosition,
    blank: @autoclosure () -> Cell
  ) {
    let requiredRows = position.row + 1
    let requiredColumns = Swift.max(columnCount, position.column + 1)

    var newCells: Cells = []

    for row in 0..<requiredRows {
      var newRow: Row = []
      for column in 0..<requiredColumns {
        let pos = GridPosition(column: column, row: row)
        if let cell = self[at: pos] {
          newRow.append(cell)
        } else {
          newRow.append(blank())
        }
      }
      newCells.append(newRow)
    }

    self.cells = newCells

//    #warning("Need to separate inherent dimensions from user-defined 'frame'")
    //    self.cells = newCells
    //    self.columns = requiredColumns
    //    self.rows = requiredRows
  }

  public mutating func resize(
    by amount: GridDimensions,
    at edges: GridEdge.Set
  ) {
    let rows = amount.rows
    let columns = amount.columns

    for edge in GridEdge.allCases where edges.contains(GridEdge.Set(edge)) {
      switch edge.gridAxis {
        case .vertical:
          if rows > 0 {
            addRows(to: edge, count: rows)
          } else if rows < 0 {
            removeRows(from: edge, count: -rows)
          }
        case .horizontal:
          if amount.columns > 0 {
            addColumns(to: edge, count: columns)
          } else if columns < 0 {
            removeColumns(from: edge, count: -columns)
          }
      }
    }
  }

  public mutating func resize(
    by amount: GridDimensions,
    at boundaryPoint: GridBoundaryPoint
  ) {
    let edges = boundaryPoint.affectedEdges
    self.resize(by: amount, at: edges)
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

  //#warning("Have changed approach regarding GridPosition, no longer stored on GridCell, so will need to fix this up")
  public mutating func addRow(to edge: GridEdge) {
    switch edge {
      case .top:
        let newRow: Row = (0..<columnCount).map { _ in Cell.createBlank() }
        cells.insert(newRow, at: 0)
      //        rows += 1
      //        reindexPositions()

      case .bottom:
        let newRow: Row = (0..<columnCount).map { _ in Cell.createBlank() }
        cells.append(newRow)
      //        rows += 1
      //        reindexPositions()

      default:
        break  // handled elsewhere
    }
  }

  //#warning("Have changed approach regarding GridPosition, no longer stored on GridCell, so will need to fix this up")
  public mutating func removeRow(from edge: GridEdge) {
    precondition(rowCount > 1, "Cannot remove last row")

    switch edge {
      case .top:
        cells.removeFirst()
      case .bottom:
        cells.removeLast()
      default:
        fatalError("Invalid edge for row removal")
    }

    //    rows -= 1
    //    reindexPositions()
  }

  public mutating func addColumn(to edge: GridEdge) {
    precondition(edge == .leading || edge == .trailing)

    for rowIndex in 0..<rowCount {
      if edge == .leading {
        cells[rowIndex].insert(Cell.createBlank(), at: 0)
      } else {
        cells[rowIndex].append(Cell.createBlank())
      }
    }

    //    columns += 1
    //    reindexPositions()
  }

  #warning(
    "Have changed approach regarding GridPosition, no longer stored on GridCell, so will need to fix this up")

  public mutating func removeColumn(from edge: GridEdge) {
    precondition(columnCount > 1, "Cannot remove last column")

    let targetColumn = (edge == .leading) ? 0 : columnCount - 1

    for rowIndex in 0..<rowCount {
      cells[rowIndex].remove(at: targetColumn)
    }

    //    columns -= 1
    //    reindexPositions()
  }
}
