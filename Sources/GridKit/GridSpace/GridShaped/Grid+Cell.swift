//
//  Grid+Cell.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/1/2026.
//

import Foundation

public protocol GridCell: Identifiable {
  associatedtype Value
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
    let characterCells = line.enumerated().map { columnIndex, character in
      Cell(from: character)
    }
    
    let paddingCells = (line.count..<targetWidth).map { colIndex in
      let position = GridPosition(row: rowIndex, column: colIndex)
      return Cell.createBlank()
    }
    
    return characterCells + paddingCells
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
