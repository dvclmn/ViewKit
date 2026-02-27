//
//  Grid+Subscripts.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/11/2025.
//

extension GridShaped {

  public subscript(row rowIndex: Int, col colIndex: Int) -> Cell? {
    get { cells[safe: rowIndex]?[safe: colIndex] }
    set {
      guard let newValue,
        cells.indices.contains(rowIndex),
        cells[rowIndex].indices.contains(colIndex)
      else { return }
      cells[rowIndex][colIndex] = newValue
    }
  }

  public subscript(row rowIndex: Int) -> Row? {
    get { cells[safe: rowIndex] }
    set { cells[safe: rowIndex] = newValue }
  }

  public subscript(column columnIndex: Int) -> [Cell] {
    get {
      cells.compactMap { row in
        row[safe: columnIndex]
      }
    }
    set {
      for i in cells.indices {
        cells[i][safe: columnIndex] = newValue[i]
      }
    }
  }

  public subscript(at position: GridPosition) -> Cell? {
    get {
      guard isPositionValid(position) else { return nil }
      return cells[position.row][position.column]
    }
    set {
      guard isPositionValid(position) else {
        /// No auto-expand here. Use `set(_:at:)` instead.
        return
      }
      cells[position.row][position.column] = newValue ?? .createBlank()
    }
  }
}
