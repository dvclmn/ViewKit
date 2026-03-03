//
//  StringStack.swift
//  TextCore
//
//  Created by Dave Coleman on 14/9/2024.
//

import SwiftUI
import BasePrimitives

/// A structure representing a multiline string as a mutable stack of character rows.
public struct StringStack: GridShaped {

  public typealias Cell = Character
  public typealias Row = [Cell]
  public typealias Element = Row

  public var cells: Rows

  public init(cells: Rows) {
    self.cells = cells
  }
}

// MARK: - Convenience Initialisers
extension StringStack {

  public init(_ cells: Rows) {
    let normalised = Self.normalisedRows(
      cells,
      alignment: .leading,
      paddingCell: " ",
      truncationCell: "%"
    )
    self.cells = normalised
  }

  public init(_ string: String) {
    self.init(stringLiteral: string)
  }

  public init(rows: [String], padToUniformWidth: Bool = true) {
    let cells = rows.map { Array($0) }
    self.init(cells)
  }
}
extension StringStack {

  public var stringRows: [String] { cells.map { String($0) } }
  public var string: String { stringRows.joined("\n") }

}

extension StringStack: ExpressibleByUnicodeScalarLiteral {
  public init(unicodeScalarLiteral value: Character) {
    self.init([[value]])
  }
}

extension StringStack: ExpressibleByStringLiteral {
  public init(stringLiteral value: String) {
    let characters: [Cell] = Array(value)
    self.init([characters])
  }
}

extension StringStack: CustomStringConvertible {
  public var description: String { string }
}

extension StringStack: CustomDebugStringConvertible {
  public var debugDescription: String {
    string
    //    return DisplayString {
    //    }.plainText
  }
}
