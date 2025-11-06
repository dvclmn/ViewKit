//
//  GridRepresentible.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/11/2025.
//

import Foundation

public protocol GridShaped: Sequence, ExpressibleByArrayLiteral {
  associatedtype Value
  typealias Cells = [[Value]]
  typealias Row = [Value]
  var cells: Cells { get set }

  init(_ cells: Cells, rowValidation: RowValidationStrategy)
}

public enum RowValidationStrategy {
  case autoFix(visualDebug: Bool = false)
  case throwError
}

extension GridShaped {
  public var isEmpty: Bool {
    cells.isEmpty || cells.allSatisfy { $0.isEmpty }
  }
}

// MARK: - Sequence conformance
extension GridShaped {
  
  public func makeIterator() -> IndexingIterator<Cells> {
    cells.makeIterator()
  }
  
  public func map<T>(_ transform: (Row) -> T) -> [T] {
    cells.map(transform)
  }
  
  public func enumerated() -> EnumeratedSequence<Cells> {
    cells.enumerated()
  }

  mutating func append(_ row: Row) {
    cells.append(row)
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
extension GridShaped {
  public init(arrayLiteral elements: Row...) {
    self.init(elements, rowValidation: .autoFix())
//    self.cells = elements
  }
}


//public protocol GridRepresentable {
//  associatedtype Cell
//  var gridHeight: Int { get }
//  var gridWidth: Int { get }
//
//  subscript(row row: Int) -> [Character] { get set }
//  //  func elementAt(row: Int, column: Int) -> Cell?
//}
//
////extension GridRepresentable where Self.Cell == Character {
////  public var string: String { self.map { String($0) }.joined(separator: "\n") }
////}
//
//extension Array: GridRepresentable where Element: MutableCollection, Element.Index == Int {
//  public typealias Cell = Element.Element
//
//  public var gridHeight: Int { count }
//  public var gridWidth: Int { self.map { $0.count }.max() ?? 0 }
//
//  public subscript(row row: Int) -> [Cell] {
//    get { self[safe: row] ?? [] }
//    set {
//      if row < self.count {
//        self[row: row] = newValue
//
//      } else if row == self.count {
//        self.append(newValue)
//      }
//    }
//  }
//
//  public subscript(col colIndex: Int) -> [Cell]? {
//    get {
//      guard gridWidth > colIndex else { return nil }
//      return indices.compactMap { row in
//        self[row: row]
//      }
//    }
//    //    get { self[safe: row] ?? [] }
////    set {
////      if row < self.count {
////        self[row] = newValue
////
////      } else if row == self.count {
////        self.append(newValue)
////      }
////    }
//  }
//
//  //  public func elementAt(row: Int, column: Int) -> Cell? {
//  //    guard indices.contains(row) else { return nil }
//  //    let rowArray = self[row]
//  //    return rowArray.indices.contains(column) ? rowArray[column] : nil
//  //  }
//
//  public func column(_ index: Int) -> [Cell]? {
//    guard gridWidth > index else { return nil }
//    return indices.compactMap { row in
//      elementAt(row: row, column: index)
//    }
//  }
//}
