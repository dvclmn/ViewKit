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
  public typealias Stack = [[Character]]
  public typealias Value = Character

  public var cells: [[Character]]

  public init(
    _ cells: Stack,
    rowValidation: RowValidationStrategy = .autoFix()
  ) {

    switch rowValidation {
      case .autoFix(let debugOption):
        self.cells = patchedStack(cells, visualDebug: debugOption) ?? []

      case .throwError:
        precondition(
          cells.allSatisfy { $0.count == width },
          "Non-rectangular StringStack: all rows must have equal width"
        )
        self.cells = cells
    }
  }

  /// ``Swift/String/substringLines(subsequenceStrategy:)``
  public init(_ string: String) {
    self.init(string.substringLines().map { Array($0) })
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

  public var height: Int {
    let value = cells.count
    //    print("Stack Height: \(value)")
    return value
  }
  public var width: Int { cells.map { $0.count }.max() ?? 0 }

  public var rows: [String] { cells.map { String($0) } }

  /// Accesses or modifies the row of characters at the specified index.
  ///
  /// - Parameter row: The zero-based index of the row to access or modify.
  /// - Returns: The array of `Character` representing the row at the given index, or
  ///   an empty array if the index is out of bounds.
  ///
  /// - Note:
  ///   - If the getter is called with a row index greater than or equal to `height`,
  ///     it returns an empty array.
  ///   - If the setter is called with a row index less than `height`, it replaces the existing row.
  ///   - If the setter is called with a row index equal to `height`, it appends the new row at the end.
  ///   - Setting with a row index greater than `height` has no effect.
  public subscript(row row: Int) -> [Character] {
    get { cells[safe: row] ?? [] }
    set {
      if row < cells.count {
        cells[row] = newValue

      } else if row == cells.count {
        cells.append(newValue)
      }
    }
  }
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
    self.init([characters])
  }
}

extension StringStack: CustomStringConvertible {
  public var description: String { string }
}
  
