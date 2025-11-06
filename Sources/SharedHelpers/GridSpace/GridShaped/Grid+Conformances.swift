//
//  Grid+Conformances.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/11/2025.
//

import Foundation

// MARK: - Collection conformance
extension GridShaped {
  
  public var startIndex: Int { cells.startIndex }
  public var endIndex: Int { cells.endIndex }
  
  public subscript(position: Int) -> Row {
    return cells[position]
  }
  
  public func index(after i: Int) -> Int {
    return cells.index(after: i)
  }
  
  public func makeIterator() -> IndexingIterator<Cells> {
    cells.makeIterator()
  }
  
  public func map<T>(_ transform: (Row) -> T) -> [T] {
    cells.map(transform)
  }
  
  public func enumerated() -> EnumeratedSequence<Cells> {
    cells.enumerated()
  }
  
  public mutating func append(_ row: Row) {
    cells.append(row)
//    fatalError("GridShaped.append(_:) must be implemented by conforming type.")
  }
}

/// ```
/// // Can write this:
/// guard !self.isEmpty else { return [] }
///
/// // Instead of this:
/// guard !self.isEmpty else { StringStack([]) }
///
/// ```
//extension GridShaped {
//  public init(arrayLiteral elements: Self.Row...) {
//    self.init(elements, fallback: nil)
////    self = Self.create(elements)
//  }
//}

