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
  public var cells: Cells

  public init(_ cells: Cells, rowValidation: RowValidation<StringStack>) {
    switch rowValidation {
      case .patch(let strategy, let shouldDebug):
        let patched =
          Self.patchedGrid(
            cells,
            visualDebug: shouldDebug,
            repair: strategy
          ) ?? []
        self.cells = patched

      case .ignore:
        self.cells = cells

      case .throwError:
        let canonicalWidth = cells.first?.count ?? 0
        precondition(
          cells.allSatisfy { $0.count == canonicalWidth },
          "Non-rectangular StringStack: all rows must have equal width"
        )
        self.cells = cells
    }
  }
  //  public init(
  //    _ cells: Stack,
  //    rowValidation: RowValidationStrategy = .autoFix()
  //  ) {
  //
  //
  //  }

  /// ``Swift/String/substringLines(subsequenceStrategy:)``
  //  public init(_ string: String) {
  //    self.init(string.substringLines().map { Array($0) })
  //  }

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
    let characters = Array(value)
    //    let characters: [Character] = value.unicodeScalars.map { scalar in
    //      Character(scalar)
    //    }
//    self.init([characters])
    self.init([characters], rowValidation: .ignore)
  }
}

extension StringStack: CustomStringConvertible {
  public var description: String { string }
}

