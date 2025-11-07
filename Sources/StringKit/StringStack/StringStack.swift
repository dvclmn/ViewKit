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

  public init(_ cells: Cells) {
    let patched = Self.defaultRepair(
      cells,
      padCell: " ",
      truncationCell: "%"
    )
    self.cells = patched
  }

  public init(_ string: String) {
    self.init(stringLiteral: string)
  }
  public init(_ stringRows: [String]) {
    let rows = stringRows.map { row in
      StringStack(stringLiteral: row)
    }
    self = Self.joined(rows, along: .vertical)
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
    return DisplayString {
      string
    }.plainText
  }
}
