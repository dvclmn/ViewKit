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
    fatalError("Need to work on this")
    //    let row = self[row: rowIndex].in
    //    rows.firstIndex(where: { $0. == row })
    //    table.rows.firstIndex(where: { $0.id == self.id }).map { $0 + 1 }
  }
}
