//
//  StringStack.swift
//  TextCore
//
//  Created by Dave Coleman on 14/9/2024.
//

import SharedHelpers
import SwiftUI

/// A structure representing a multiline string as a mutable stack of character rows.
public struct StringStack {

  var stack: [[Character]]

  public init(_ stack: [[Character]]) {
    guard let width = stack.first?.count else {
      self.stack = []
      return
    }
    precondition(
      stack.allSatisfy { $0.count == width },
      "Non-rectangular StringStack: all rows must have equal width"
    )
    self.stack = stack
  }

  /// ``Swift/String/substringLines(subsequenceStrategy:)``
  public init(_ string: String) {
    self.init(string.substringLines().map { Array($0) })
  }

  /// Initializes a `StringStack` by repeating a given row
  /// *vertically* the specified number of times.
  /// - Parameters:
  ///   - row: The row of characters to repeat.
  ///   - count: The number of times to repeat the row.
  public init(
    repeating row: [Character],
    count: Int
  ) {
    self.stack = Array(repeating: row, count: count)
  }
}

extension StringStack {

  public var string: String { stack.map { String($0) }.joined("\n") }
  public var height: Int {
    let value = stack.count
    print("Stack Height: \(value)")
    return value
  }
  public var width: Int { stack.map { $0.count }.max() ?? 0 }

  public var rows: [String] { stack.map { String($0) } }

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
    get { stack[safe: row] ?? [] }
    set {
      if row < stack.count {
        stack[row] = newValue

      } else if row == stack.count {
        stack.append(newValue)
      }
    }
  }
}

extension StringStack {

  /// Indicates whether the stack contains no characters in any row.
  public var isEmpty: Bool {
    stack.isEmpty || stack.allSatisfy { $0.isEmpty }
  }

}

/// This allows writing
/// ```
/// guard !self.isEmpty else { return [] }
/// ```
///
/// rather than
/// ```
/// guard !self.isEmpty else { StringStack([]) }
/// ```
extension StringStack: ExpressibleByArrayLiteral {
  public init(arrayLiteral elements: [Character]...) {
    self.stack = elements
  }
}

extension StringStack: ExpressibleByUnicodeScalarLiteral {
  public init(unicodeScalarLiteral value: Character) {
    self.stack = [[value]]
  }
}

extension StringStack: CustomStringConvertible {
  public var description: String { string }
}

extension StringStack: Sequence {

  public func makeIterator() -> IndexingIterator<[[Character]]> {
    stack.makeIterator()
  }

  public func map<T>(_ transform: ([Character]) -> T) -> [T] {
    stack.map(transform)
  }

  public func enumerated() -> EnumeratedSequence<[[Character]]> {
    stack.enumerated()
  }

  /// Appends a new row of characters to the end of the stack.
  ///
  /// - Parameter row: The row of characters to append.
  mutating func append(_ row: [Character]) {
    stack.append(row)
  }
}
