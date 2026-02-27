//
//  GridString.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/2/2026.
//

import Foundation

//public protocol GridString: GridShaped, ExpressibleByStringLiteral where Cell == Character {
//  init(stringLiteral value: String)
//}

extension Character: BlankCreatable {
  public static func createBlank() -> Character { Character(" ") }
}

extension GridShaped where Cell == Character {
  // Any members here can freely use Character APIs, including createBlank()
  public static func blankCell() -> Cell { .createBlank() }
//}

/// This is essentially the same as `extension GridShaped where Cell == Character`
//extension GridString {

  public init(fromString string: String) {
    let cells = Self.generateCells(from: string)
    self.init(cells: cells)
  }

  public static func generateCells(from text: String) -> [[Cell]] {
    print(
      """

      Generating cells from text:
      \(text)


      """)
    let dimensions = text.gridDimensions
    let lines = text.lines(omissionStrategy: .doNotOmit)

    return lines.enumerated().map {
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
      //      let position = GridPosition(column: colIndex, row: rowIndex)
      return Cell.createBlank()
    }

    return characterCells + paddingCells
  }

  public var toString: String {
    let rowsStrings = (0..<rowCount).map { rowIndex in
      (0..<columnCount).map { columnIndex in
        let position = GridPosition(column: columnIndex, row: rowIndex)
        return String(self[at: position] ?? " ")
      }.joined()
    }
    return rowsStrings.joinedLines()
  }

}
