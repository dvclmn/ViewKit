//
//  StringStack.swift
//  TextCore
//
//  Created by Dave Coleman on 14/9/2024.
//

import SharedHelpers
import SwiftUI

/// A structure representing a multiline string as a mutable stack of character rows.
public struct StringStack: GridShaped {

  public typealias Cell = Character
  public typealias Row = [Character]

  public var cells: Cells

  public init(_ cells: Cells, fallback: Cell = "⚠️") {
    let patched = Self.patchedGrid(cells, fallback: fallback)
    self.cells = patched ?? []
  }
}

extension StringStack {
  public var string: String { cells.map { String($0) }.joined("\n") }
  public var rows: [String] { cells.map { String($0) } }
}

extension StringStack: ExpressibleByUnicodeScalarLiteral {
  public init(unicodeScalarLiteral value: Character) {
    self.init([[value]])
  }
}

extension StringStack: ExpressibleByStringLiteral {
  public init(stringLiteral value: StringLiteralType) {

    /// ``Swift/String/substringLines(subsequenceStrategy:)``
    let lines = value.substringLines().map { String($0)}
    let characters: Cells = lines.map { Array($0) }
    self.init(characters)
  }
}

extension StringStack: CustomStringConvertible {
  public var description: String { string }
}

extension StringStack {
  public static func repair(
    row: Row,
    targetWidth: Int,
    fill: Cell = " "
  ) -> Row {
    if row.count == targetWidth {
      return row

    } else if row.count < targetWidth {
      return row + Array(repeating: fill, count: targetWidth - row.count)

    } else {
      var newRow = Array(row.prefix(targetWidth - 1))
      newRow.append(fill)
      return newRow
    }
  }
}
