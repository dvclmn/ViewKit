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

    var newCells: [Cell] = []

    for row in 0..<requiredRows {
      for column in 0..<requiredColumns {
        if row < rowCount, column < columnCount {
          let position = GridPosition(column: column, row: row)
          print("GridPosition from `expandToInclude()`: \(position)")
          guard let cell = self[at: position] else { return }
          newCells.append(cell)
        } else {
          newCells.append(blank())
        }
      }
    }

    fatalError("Not yet implemented")

    #warning("Need to separate inherent dimensions from user-defined 'frame'")
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
    precondition(columnCount > count, "Cannot remove \(count) columns; only \(columns) available")
    for _ in 0..<count { removeColumn(from: edge) }
  }

  mutating func addRows(to edge: GridEdge, count: Int = 1) {
    for _ in 0..<count { addRow(to: edge) }
  }

  mutating func removeRows(from edge: GridEdge, count: Int = 1) {
    precondition(rowCount > count, "Cannot remove \(count) rows; only \(rows) available")
    for _ in 0..<count { removeRow(from: edge) }
  }

  //#warning("Have changed approach regarding GridPosition, no longer stored on GridCell, so will need to fix this up")
  public mutating func addRow(to edge: GridEdge) {
    switch edge {
      case .top:
        let newRow = (0..<columnCount).map { column in
          [
            Cell.createBlank()
          ]
          //          GridCell.createBlank(at: .init(row: 0, column: column))
        }
        cells.insert(contentsOf: newRow, at: 0)
      //        rows += 1
      //        reindexPositions()

      case .bottom:
        let newRow = (0..<columnCount).map { column in
          [
            Cell.createBlank()
          ]
          //          GridCell.createBlank(at: .init(row: rows, column: column))
        }
        cells.append(contentsOf: newRow)
      //        rows += 1
      //        reindexPositions()

      default:
        break  // handled elsewhere
    }
  }

  //#warning("Have changed approach regarding GridPosition, no longer stored on GridCell, so will need to fix this up")
  public mutating func removeRow(from edge: GridEdge) {
    precondition(rowCount > 1, "Cannot remove last row")

    let range: Range<Int>
    switch edge {
      case .top:
        range = 0..<columnCount
      case .bottom:
        range = cells.count - columnCount..<cells.count
      default:
        fatalError("Invalid edge for row removal")
    }

    cells.removeSubrange(range)
    //    rows -= 1
    //    reindexPositions()
  }

  public mutating func addColumn(to edge: GridEdge) {
    precondition(edge == .leading || edge == .trailing)

    for row in (0..<rowCount).reversed() {
      let column = (edge == .leading) ? 0 : columnCount
      let newCell = [Cell.createBlank()]
      let insertIndex = row * columnCount + (edge == .leading ? 0 : columnCount)
      cells.insert(newCell, at: insertIndex)
    }

    //    columns += 1
    //    reindexPositions()
  }

  #warning(
    "Have changed approach regarding GridPosition, no longer stored on GridCell, so will need to fix this up")

  public mutating func removeColumn(from edge: GridEdge) {
    precondition(columnCount > 1, "Cannot remove last column")

    let targetColumn = (edge == .leading) ? 0 : columnCount - 1

    for row in (0..<rowCount).reversed() {
      let index = row * columnCount + targetColumn
      cells.remove(at: index)
    }

    //    columns -= 1
    //    reindexPositions()
  }
}
