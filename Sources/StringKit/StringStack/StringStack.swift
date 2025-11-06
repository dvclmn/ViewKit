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

  //  public static var fallbackCell: Character { " " }
  public var cells: Cells

  public init(_ cells: Cells, fallback: Cell?) {
    //    self = Self.create(cells)

    //    self.cells = cells

    let patched = Self.patchedGrid(cells) { row, targetWidth in
      Self.repair(row: row, targetWidth: targetWidth, fill: fallback ?? " ")
    }

    self.cells = patched ?? []
    //    return Self(patched ?? [])
  }

  /// Initializes a `StringStack` by repeating a given row
  /// vertically, the specified number of times.
  /// - Parameters:
  ///   - row: The row of characters to repeat.
  ///   - count: The number of times to repeat the row.
  public init(repeating row: [Character], count: Int) {

    let cells = Array(repeating: row, count: count)
    self.init(cells, fallback: nil)
//    self = Self.create(cells)
  }
}

extension StringStack {
  public var string: String { cells.map { String($0) }.joined("\n") }
  public var rows: [String] { cells.map { String($0) } }
}

extension StringStack: ExpressibleByUnicodeScalarLiteral {
  public init(unicodeScalarLiteral value: Character) {
    self.init([[value]], fallback: nil)
//    self = Self.create([[value]])
  }
}

extension StringStack: ExpressibleByStringLiteral {
  public init(stringLiteral value: StringLiteralType) {

    /// ``Swift/String/substringLines(subsequenceStrategy:)``
    let lines = value.substringLines().map { substring in
      String(substring)
    }

    let characters: Cells = lines.map { string in
      Array(string)
    }
    self.init(characters, fallback: nil)
//    self = Self.create(characters)
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
