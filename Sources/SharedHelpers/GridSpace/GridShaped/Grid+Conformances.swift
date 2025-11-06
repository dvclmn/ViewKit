//
//  Grid+Conformances.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/11/2025.
//

import SwiftUI

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
  }

  public init(repeating grid: Self, count: Int) {
    precondition(count >= 0, "Repeat count must be non-negative")
    
    let newCells: Cells = grid.cells.map { row in
      Array(repeating: row, count: count).flatMap { $0 }
    }
    
    self.init(newCells)
  }
  
  public init(
    repeating grid: Self,
    count: Int,
    along axis: Axis
  ) {
    switch axis {
      case .horizontal:
        self.init(grid.cells.map { Array(repeating: $0, count: count).flatMap { $0 } })
      case .vertical:
        self.init(Array(repeating: grid.cells, count: count).flatMap { $0 })
    }
  }
  
//  public init(repeating grid: Self, count: Int) {
//    
//    var repeated: Self = []
//    for _ in 0..<count {
//      grid.rows.map { row in
//        <#code#>
//      }
////      repeated.cells.append(grid.cells)
//    }
////    let repeated = grid.rows.map { row in
////      <#code#>
////    }
////    let rows = self.rows
////  public init(repeating element: Row, count: Int) {
////    let rows = Array(repeating: element, count: count)
////    self = Self(rows)
//  }
  
  /// Repeats self
//  public func repeated() -> Self {
//
////    let thing = String(repeating: "", count: 2)
//  }
  
//  func repeated(
//    along axis: Axis,
//    count: Int
//  ) -> StringStack {
//    
//    let stack = self.cells.stacked(along: axis, repeating: count)
//    return StringStack(stack)
//  }
}


//extension StringStack {
//  public init(
//    from glyphStack: Box.GlyphStack,
//    with theme: Box.Theme,
//  ) {
//    //    print("Making StringStack from GlyphStack / and Theme \(theme)")
//    printPadded(
//      "Glyphstack width (widest row): \(glyphStack.width(for: .widestRow))",
//      "Glyphstack rows: \(glyphStack.rows)"
//    )
//    /// Convert from `GlyphType` → `Character`
//    let characterGrid = glyphStack.map { row in
//      //      print("Processing row \(row)")
//      return row.map {
//        let char = theme.glyphSet.character(for: $0)
//        //        print("Character: \(char)")
//        return char
//      }
//    }
//    //    print("Character Grid: \(characterGrid)")
//    
//    self.init(characterGrid)
//  }
//  
//}
