//
//  StringStack.swift
//  TextCore
//
//  Created by Dave Coleman on 14/9/2024.
//

import Foundation

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

extension StringStack {
  
  
  public func joinHorizontally(
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
    
    //    for i in 0..<maxHeight {
    //      let leftRow = i < self.height ? self[i] : []
    //      let rightRow = i < other.height ? other[i] : []
    //
    //      if let padding = padding {
    //        let leftPadding = i < self.height ? [] : .padded(with: padding, count: self.width)
    //        let rightPadding = i < other.height ? [] : .padded(with: padding, count: other.width)
    //
    //        //        let leftPadding = i < self.height ? [] : [Character](repeating: padding, count: self.width)
    //        //        let rightPadding = i < other.height ? [] : [Character](repeating: padding, count: other.width)
    //        result.append(leftPadding + leftRow + rightRow + rightPadding)
    //      } else {
    //        result.append(leftRow + rightRow)
    //      }
    //    }
    
    return result
  }
  
  public func joinVertically(with other: StringStack, padding: Character? = nil) -> StringStack {
    let maxWidth = Swift.max(width, other.width)
    var result = self
    
    for i in 0..<other.height {
      let row = other.row(at: i, paddedTo: maxWidth, with: padding)
      result.append(row)
    }
    
    return result
  }

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

