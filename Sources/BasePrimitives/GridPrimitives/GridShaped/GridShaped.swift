//
//  GridRepresentible.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/11/2025.
//

/// Notes:
/// - Should bear in mind the idea of both
///   a) Inherent/uncropped dimensions
///   b) As distinct from a user's cropped frame / view onto the grid

/// `GridPosition` is a lightweight value type used for addressing.
/// Cells do not store positions.
/// - The `subscript(at:)` never expands the grid; use `set(_:at:)` to auto-expand.
/// - Column-wise operations normalize rows to rectangular shape before applying changes.
public protocol GridShaped: Collection, ExpressibleByArrayLiteral where Element == Row, Index == Int {

  associatedtype Cell: BlankCreatable, Sendable, Equatable, Hashable

  typealias Rows = [[Cell]]
  typealias Row = [Cell]

  var rows: Rows { get set }

  init(rows: Rows)
  init(_ rows: Rows)

  static func normalisedRows(
    _ rows: Rows,
    alignment: GridAlignment,
    paddingCell: Cell,
    truncationCell: Cell?
  ) -> Rows
}

public protocol BlankCreatable {
  static func createBlank() -> Self
}

extension GridShaped {
  public init(arrayLiteral elements: Row...) {
    self.init(elements)
  }
}

extension GridShaped {
  public init(_ rows: Self.Rows) {
    self.init(rows: rows)
  }
}
