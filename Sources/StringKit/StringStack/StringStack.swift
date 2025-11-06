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
  public static var fallbackCell: Character { " " }
  

  public typealias Cell = Character
  public var cells: Cells

  public init(_ cells: Cells) {
    self.cells = cells
  }

  /// Initializes a `StringStack` by repeating a given row
  /// vertically, the specified number of times.
  /// - Parameters:
  ///   - row: The row of characters to repeat.
  ///   - count: The number of times to repeat the row.
  public init(repeating row: [Character], count: Int) {
    self.cells = Array(repeating: row, count: count)
  }
}

extension StringStack {
  public var string: String { cells.map { String($0) }.joined("\n") }
  public var rows: [String] { cells.map { String($0) } }
}

extension StringStack: ExpressibleByUnicodeScalarLiteral {
  public init(unicodeScalarLiteral value: Character) {
    self.cells = [[value]]
  }
}

extension StringStack: ExpressibleByStringLiteral {
  public init(stringLiteral value: StringLiteralType) {

    /// ``Swift/String/substringLines(subsequenceStrategy:)``
    let lines = value.substringLines().map { substring in
      String(substring)
    }

    let characters: [[Character]] = lines.map { string in
      Array(string)
    }

    self = Self.create(characters)
//    self.init(
//      characters,
//      rowValidation: .patch(
//        {
//          row,
//          targetWidth in
//
//          return Self.defaultRepair(
//            row: row,
//            targetWidth: targetWidth,
//            fill: " "
//          )
//        },
////        visualDebug: true
//      )
//    )

    //    let characters = lines.map { string in
    //      Array(string)
    //    }
    //    self.init(.map { Array($0) })

    //    let characters = Array(value)
    //    let characters: [Character] = value.unicodeScalars.map { scalar in
    //      Character(scalar)
    //    }
    //    self.init([characters])
    //    self.init([characters], rowValidation: .ignore)
  }
}

extension StringStack: CustomStringConvertible {
  public var description: String { string }
}
