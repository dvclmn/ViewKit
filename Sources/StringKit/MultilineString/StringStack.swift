//
//  StringStack.swift
//  TextCore
//
//  Created by Dave Coleman on 14/9/2024.
//

import SwiftUI

/// A structure representing a multiline string as a mutable stack of character rows.
public struct StringStack {

  private var stack: [[Character]]

  public init(_ grid: [[Character]]) {
    self.stack = grid
  }

  /// ``Swift/String/substringLines(subsequenceStrategy:)``
  public init(_ string: String) {
    self.init(string.substringLines().map { Array($0) })
  }

}

extension StringStack {

  public var string: String { stack.map { String($0) }.joined("\n") }
  public var height: Int { stack.count }
  public var width: Int { stack.map { $0.count }.max() ?? 0 }

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
  public subscript(row: Int) -> [Character] {
    get {
      guard row < stack.count else { return [] }
      return stack[row]
    }
    set {
      if row < stack.count {
        stack[row] = newValue

      } else if row == stack.count {
        stack.append(newValue)
      }
    }
  }

  /// Indicates whether the stack contains no characters in any row.
  public var isEmpty: Bool {
    stack.isEmpty || stack.allSatisfy { $0.isEmpty }
  }
}

// MARK: - Joining
extension StringStack {

  /// Right now, if padding is nil, shorter rows or columns simply “disappear” —
  /// this can lead to jagged edges. You might prefer to default to space
  /// padding when widths/heights don’t match, unless nil is explicitly
  /// intended to mean “truncate”.
  
  /// Explicit handling could help readability:
  /// `let padChar = padding ?? " "`
  public static func joined(
    _ strings: StringStack...,
    along axis: Axis,
    padding: Character? = nil
  ) -> StringStack {
    strings.reduce(StringStack([])) { partial, string in
      switch axis {
        case .horizontal:
          partial.joinedHorizontally(with: string, padding: padding)

        case .vertical:
          partial.joinedVertically(with: string, padding: padding)
      }
    }
  }

  private func joinedHorizontally(
    with other: StringStack,
    padding: Character? = nil
  ) -> StringStack {
    let maxHeight = Swift.max(self.height, other.height)
    var result = StringStack([])

    for i in 0..<maxHeight {
      let left = self.row(at: i, paddedTo: self.width, with: padding)
      let right = other.row(at: i, paddedTo: other.width, with: padding)
      result.append(left + right)
    }

    return result
  }

  private func joinedVertically(with other: StringStack, padding: Character? = nil) -> StringStack {
    let maxWidth = Swift.max(width, other.width)
    var result = self

    for i in 0..<other.height {
      let row = other.row(at: i, paddedTo: maxWidth, with: padding)
      result.append(row)
    }

    return result
  }
  
  // Ensure all rows have consistent width
  public func normalized(
    toWidth width: Int? = nil,
    paddingCharacter: Character = " "
  ) -> StringStack {
    let targetWidth = width ?? self.width
    var result = StringStack([])
    for row in stack {
      var normalizedRow = row
      if normalizedRow.count < targetWidth {
        normalizedRow.append(contentsOf: Array(repeating: paddingCharacter, count: targetWidth - normalizedRow.count))
      } else if normalizedRow.count > targetWidth {
        normalizedRow = Array(normalizedRow.prefix(targetWidth))
      }
      result.append(normalizedRow)
    }
    return result
  }

//  func normalised(toWidth width: Int, height: Int, padding: Character) -> StringStack {
//    var rows = stack
//    rows = rows.map { $0 + .padded(with: padding, count: width - $0.count) }
//    if rows.count < height {
//      let emptyRow = .padded(with: padding, count: width)
//      rows += Array(repeating: emptyRow, count: height - rows.count)
//    }
//    return StringStack(rows)
//  }
  
  private static func fill(_ char: Character, count: Int) -> [Character] {
    count > 0 ? Array(repeating: char, count: count) : []
  }

  private func row(
    at index: Int,
    paddedTo width: Int,
    with char: Character?
  ) -> [Character] {
    guard index < stack.count else {
      return char.map { .padded(with: $0, count: width) } ?? []
    }
    var row = stack[index]
    if let char = char, row.count < width {
      row += .padded(with: char, count: width - row.count)
    }
    return row
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
