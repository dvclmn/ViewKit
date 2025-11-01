//
//  StringStack+Ext.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/11/2025.
//

import Foundation

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
