//
//  GridRepresentible.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/11/2025.
//

import Foundation

public protocol GridShaped: Sequence, ExpressibleByArrayLiteral, Collection {
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
  public init(_ cells: Cells, rowValidation: RowValidationStrategy = .autoFix()) {
    //    self.cells = cells
    switch rowValidation {
      case .autoFix(let debugOption):
        self.cells = Self.patchedGrid(cells, visualDebug: debugOption) ?? []

      case .throwError:
        precondition(
          cells.allSatisfy { $0.count == width },
          "Non-rectangular StringStack: all rows must have equal width"
        )
        self.cells = cells
    }
  }
  //  init(repeating row: Row, count: Int)

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

/// ```
/// // Can write this:
/// guard !self.isEmpty else { return [] }
///
/// // Instead of this:
/// guard !self.isEmpty else { StringStack([]) }
///
/// ```
extension GridShaped {
  public init(arrayLiteral elements: Row...) {
    self.init(elements, rowValidation: .autoFix())
  }
}
