//
//  GridString.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/2/2026.
//

import Foundation

extension Character: GridCell {}

extension Character: Blankable {
  public static func createBlank() -> Character {
    #if DEBUG
    // ░ ╳ ✕ ▚ ∑ η ✳
    Character("▚")

    #else
    Character(" ")

    #endif
  }
  
  
}

extension GridShaped where Cell == Character {

  /// Build from text with explicit policies
  public init(
    fromString text: String,
    parsing options: GridParsingOptions = .default,
    normalisation policy: GridNormalizationPolicy<Cell>? = nil
  ) {
    let parsed = Self.parse(text: text, options: options)
    let rows = policy.map { Self.normaliseRows(parsed.rows, policy: $0) } ?? parsed.rows
    self.init(rows: rows)
  }

  public static func generateCells(from text: String) -> [[Cell]] {

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
      return Cell.createBlank()
    }

    return characterCells + paddingCells
  }

}
