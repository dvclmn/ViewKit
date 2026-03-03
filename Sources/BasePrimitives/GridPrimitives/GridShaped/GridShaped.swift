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

  associatedtype Cell: BlankCreatable, Equatable, Sendable

  typealias Rows = [[Cell]]
  typealias Row = [Cell]

  var cells: Rows { get set }

  init(cells: Rows)
  init(_ cells: Rows)

  static func normalisedRows(
    _ cells: Rows,
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
  public init(_ cells: Self.Rows) {
    self.init(cells: cells)
  }
}
