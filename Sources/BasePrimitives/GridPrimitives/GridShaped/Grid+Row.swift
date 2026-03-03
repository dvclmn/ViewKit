//
//  Grid+Row.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/1/2026.
//

extension GridShaped {
  
  public static func createEmptyRows(rowCount: Int, columnCount: Int) -> Rows {
    let row = Self.createEmptyRow(columnCount: columnCount)
    return Array(repeating: row, count: rowCount)
  }
  
  public static func createEmptyRow(columnCount: Int) -> Row {
    Array(repeating: Cell.createBlank(), count: columnCount)
  }

  func rowNumber(for rowIndex: Int) -> Int? {
    guard isRowValid(rowIndex) else { return nil }
    return rowIndex + 1
  }
}
