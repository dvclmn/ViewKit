//
//  Grid+Render.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/2/2026.
//

import Foundation

public struct GridRenderOptions: OptionSet, Sendable {
  public let rawValue: Int
  public init(rawValue: Int) { self.rawValue = rawValue }

  public static let trimTrailingSpacesPerLine = GridRenderOptions(rawValue: 1 << 0)
  public static let includeTerminalNewline = GridRenderOptions(rawValue: 1 << 1)
  public static let useWidestRowAsWidth = GridRenderOptions(rawValue: 1 << 2)
  public static let useFirstNonEmptyRowAsCanonical = GridRenderOptions(rawValue: 1 << 3)
  public static let preserveLeadingEmptyRows = GridRenderOptions(rawValue: 1 << 4)

  public static let `default`: GridRenderOptions = []
}

extension GridShaped where Cell == Character {

  public var toString: String { toString() }
  
  public func toString(options: GridRenderOptions = .default) -> String {

    //    let width: Int = {
    //      if options.contains(.useWidestRowAsWidth) {
    //        return widestRow
    //      } else if options.contains(.useFirstNonEmptyRowAsCanonical) {
    //        return canonicalColumnCount
    //      }
    //    }()
    //
    //    let rowsToRender: [Row] = {
    //      guard options.contains(.preserveLeadingEmptyRows) else {
    //        /// Skip leading empty rows
    //        return Array(rows.drop { $0.isEmpty })
    //      }
    //      return rows
    //    }()

    let lines = (0..<rowCount).map { rowIndex -> String in
      let line = (0..<columnCount).map { col in
        let position = GridPosition(column: col, row: rowIndex)
        return self[at: position] ?? Cell.createBlank()
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

  //  public var toString: String {
  //    let rowsStrings = (0..<rowCount).map { rowIndex in
  //      (0..<columnCount).map { columnIndex in
  //        let position = GridPosition(column: columnIndex, row: rowIndex)
  //        return String(self[at: position] ?? " ")
  //      }.joined()
  //    }
  //    return rowsStrings.joinedLines()
  //  }

}

extension String {
  fileprivate func rstrip() -> String {
    var view = self[...]
    while view.last == " " { view = view.dropLast() }
    return String(view)
  }
}
