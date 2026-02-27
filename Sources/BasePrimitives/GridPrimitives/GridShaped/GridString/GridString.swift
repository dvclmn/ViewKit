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

  /// Build from text with explicit policies
  public init(
    fromString text: String,
    parsing options: GridParsingOptions = .default,
    normalisation policy: GridNormalizationPolicy<Cell>? = nil
  ) {
    let parsed = Self.parse(text: text, options: options)
    let rows = policy.map { Self.normaliseRows(parsed.rows, policy: $0) } ?? parsed.rows
    self.init(cells: rows)
  }

  // Any members here can freely use Character APIs, including createBlank()
  //  public static func blankCell() -> Cell { .createBlank() }
  //}

  /// This is essentially the same as `extension GridShaped where Cell == Character`
  //extension GridString {

  //  public init(fromString string: String) {
  //    let cells = Self.generateCells(from: string)
  //    self.init(cells: cells)
  //  }

  public static func generateCells(from text: String) -> [[Cell]] {
    //    print(
    //      """
    //
    //      Generating cells from text:
    //      \(text)
    //
    //
    //      """)
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

  public var toString: String {
    let rowsStrings = (0..<rowCount).map { rowIndex in
      (0..<columnCount).map { columnIndex in
        let position = GridPosition(column: columnIndex, row: rowIndex)
        return String(self[at: position] ?? " ")
      }.joined()
    }
    return rowsStrings.joinedLines()
  }

  public func toString(options: GridRenderOptions = .default) -> String {
    let lines = (0..<rowCount).map { rowIndex -> String in
      let line = (0..<columnCount).map { col in
        let position = GridPosition(column: col, row: rowIndex)
        return self[at: position] ?? " "
      }
      var s = String(line)
      if options.contains(.trimTrailingSpacesPerLine) {
        s = s.rstrip()
      }
      return s
    }
    let joined = lines.joined(separator: "\n")
    guard options.contains(.includeTerminalNewline) else {
      return joined
    }
    return joined + "\n"
  }

}

extension String {
  fileprivate func rstrip() -> String {
    var view = self[...]
    while view.last == " " { view = view.dropLast() }
    return String(view)
  }
}
