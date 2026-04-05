//
//  Grid+Subscripts.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/11/2025.
//

extension GridShaped {

  public subscript(row rowIndex: Int, col colIndex: Int) -> Cell? {
    get { rows[safe: rowIndex]?[safe: colIndex] }
    set { rows[safe: rowIndex]?[safe: colIndex] = newValue }
  }

  public subscript(row rowIndex: Int) -> Row? {
    get { rows[safe: rowIndex] }
    set { rows[safe: rowIndex] = newValue }
  }

  public subscript(column columnIndex: Int) -> [Cell] {
    get {
      rows.compactMap { row in
        row[safe: columnIndex]
      }
    }
    set {
      for i in rows.indices {
        rows[safe: i]?[safe: columnIndex] = newValue[i]
      }
    }
  }

  public subscript(at position: GridPosition) -> Cell? {
    get {
      guard isPositionValid(position) else { return nil }
      return rows[position.row][position.column]
    }
    set {
      guard isPositionValid(position) else {
        /// No auto-expand here. Use `set(_:at:)` instead.
        return
      }
      rows[position.row][position.column] = newValue ?? .createBlank()
    }
  }
}
