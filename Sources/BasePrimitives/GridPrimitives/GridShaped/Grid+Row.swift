//
//  Grid+Row.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/1/2026.
//

extension GridShaped {
  public static func emptyRows(rowCount: Int, columnCount: Int) -> Cells {
    let row = Self.emptyRow(columnCount: columnCount)
    return Array(repeating: row, count: rowCount)
  }
  public static func emptyRow(columnCount: Int) -> Row {
    Array(repeating: Cell.createBlank(), count: columnCount)
    //    return Row(cells: cells.toIdentifiedArray)
  }

  func rowNumber(for rowIndex: Int) -> Int? {
    guard isRowValid(rowIndex) else { return nil }
    return rowIndex + 1
  }
}
