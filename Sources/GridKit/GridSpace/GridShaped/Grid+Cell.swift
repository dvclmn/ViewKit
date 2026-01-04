//
//  Grid+Cell.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/1/2026.
//

import Foundation

public protocol GridCell: Identifiable {
  associatedtype Value: Equatable

  var value: Value { get set }
  static func createBlank() -> Self
  init(from value: Value)
}

extension GridShaped where Cell.Value == Character {
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
    let characterCells = line.map(Cell.init(from:))

    let paddingCells = (line.count..<targetWidth).map { colIndex in
      let position = GridPosition(row: rowIndex, column: colIndex)
      return Cell.createBlank()
    }

    return characterCells + paddingCells
  }

  public var toText: String {
    let rowsStrings = (0..<rowCount).map { rowIndex in
      (0..<columnCount).map { columnIndex in
        let position = GridPosition(row: rowIndex, column: columnIndex)
        return String(self[at: position]?.value ?? " ")
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
