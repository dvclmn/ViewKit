//
//  CellContext.swift
//  SumBuddy
//
//  Created by Dave Coleman on 13/10/2025.
//

import SwiftUI
import ToolKit


//typealias CellHeight = (position: Cell.Position, height: Int)
//typealias CellPositionHeights = [Cell.Position: Int]

/// Who needs to use this?
///
/// - `CellTextView`, will update the heights via
///   the `Text.LayoutKey` preference key
/// - Content view wants the heights String for viewing
//struct CellContext {
//
//  var cellHeights: CellPositionHeights = [:]
//
//  /// Establish string column width
//  private let colStringWidth = 8  // enough for "AA10:123"
//
//}
//
//extension CellContext {
//
//  func tallestCellHeight(
//    in rowID: Row.ID,
//    table: Table
//  ) -> Int? {
//    return
//      cellHeights
//      .compactMap { cellPosition, height in
//        let rowPosition = table.rowPosition(of: rowID)
//        
//        return cellPosition.row == rowPosition ? height : nil
//      }
//      .max()
//  }
//
//  /// Expressed in 'x characters high', aka 'x lines high'
//  mutating func updateCellHeights(
//    cellPosition: Cell.Position,
//    //    cellID: Cell.ID,
//    //    rowID: Row.ID,
//    textLayout: Text.LayoutKey.Value
//  ) {
//    let count = textLayout.lineCount
//    //    let position = store.data.cellPosition(of: cellID)
//    //    let cellInRow = CellInRow(cellID, rowID)
//    cellHeights[cellPosition] = count
//  }
//
//  func heightString(for table: Table) -> String {
//
//    let sorted = heightsSorted(for: table)
//
//    /// Group by row index
//    let grouped = Dictionary(grouping: sorted, by: { $0.position.row })
//    let rowsText = buildRows(for: table, grouped: grouped)
//
//    let headerLine = table.headers.indices
//      .map { $0.columnLetter.padded(to: colStringWidth) }
//      .joined()
//
//        return DisplayString {
//          "\n"
//          headerLine
//          rowsText.joined("\n")
//          "\n"
//        }.plainText
//
////    return (["\n"] + [headerLine] + rowsText).joined(separator: "\n")
//  }
//
//  private func heightsSorted(for table: Table) -> [CellHeight] {
//
//    /// Step 1: collect cell positions + heights
//    let entries: [CellHeight] = cellHeights.compactMap { key, value -> CellHeight? in
//      //      guard let pos = key else { return nil }
//      //      guard let pos = table.cellPosition(of: key) else { return nil }
//      return (key, value)
//    }
//
//    /// Step 2: sort by row then column
//    let sorted = entries.sorted {
//      guard $0.position.row == $1.position.row else {
//        return $0.position.row < $1.position.row
//      }
//      return $0.position.column < $1.position.column
//    }
//
//    return sorted
//  }
//
//  private func buildRows(
//    for table: Table,
//    grouped: [Int: [CellHeight]]
//  ) -> [String] {
//    /// Build rows
//    let rowsText: [String] = (0..<table.rows.count).map { rowIndex in
//      let cellsInRow = grouped[rowIndex] ?? []
//      let mapped: [String] = table.headers.indices.map { colIndex in
//        guard let match = cellsInRow.first(where: { $0.position.column == colIndex }) else {
//          return "·".padded(to: colStringWidth)  // placeholder for empty cell
//        }
//        let pos = match.position
//        let name = "\(pos.column.columnLetter)\(pos.row + 1)"
//        return "\(name):\(match.1)".padded(to: colStringWidth)
//      }
//      return mapped.joined()
//    }
//    return rowsText
//  }
//}
