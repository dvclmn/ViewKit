//
//  Grid+Cell.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/1/2026.
//

import Foundation

extension Character: GridCell {
  public static func createBlank() -> Character { Character("") }
}

extension GridShaped where Cell == Character {
  public static func generateCells(from text: String) -> [Cell] {
    let dimensions = text.gridDimensions
    let lines = text.substringLines(subsequenceStrategy: .omitLastLineIfEmpty)

    return lines.enumerated().flatMap {
      rowIndex,
      line in
      createRowCells(
        from: line,
        rowIndex: rowIndex,
        targetWidth: dimensions.width
      )
    }
  }

  private static func createRowCells(
    from line: Substring,
    rowIndex: Int,
    targetWidth: Int
  ) -> [Cell] {
    let characterCells = line.map(Cell.init)

    let paddingCells = (line.count..<targetWidth).map { colIndex in
      let position = GridPosition(column: colIndex, row: rowIndex)
      return Cell.createBlank()
    }

    return characterCells + paddingCells
  }

  public var toText: String {
    let rowsStrings = (0..<rowCount).map { rowIndex in
      (0..<columnCount).map { columnIndex in
        let position = GridPosition(column: columnIndex, row: rowIndex)
        return String(self[at: position] ?? " ")
      }.joined()
    }
    return rowsStrings.joinedLines()
  }
}

enum GridCellError: LocalizedError {
  case outOfBounds(index: Int)
  case indexOutOfRange(index: Int, count: Int)

  var errorDescription: String? {
    switch self {
      case .outOfBounds(let index):
        return "Adjusted index \(index) is out of bounds"
      case .indexOutOfRange(let index, let count):
        return "Cell index \(index) is out of range (valid range: 0...\(count-1))"
    }
  }
}
