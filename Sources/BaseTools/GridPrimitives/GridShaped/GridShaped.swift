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
///
/// Note on Row-major vs Column-major — these describe storage order, not shape.
/// This Grid is row-major, storing `[[Cell]]`where outer = rows).
/// This is orthogonal to raggedness. A ragged grid is always ragged along the
/// *minor* axis. Which is Columns in this Row-major case
///
/// Note: I am approaching Grid normalisation this way, for GridShaped:
/// Store Ragged, think Rectangular
public protocol GridShaped: Collection, ExpressibleByArrayLiteral where Element == Row, Index == Int {

  /// Note: No Identifiable here — identity comes from GridPosition at the use site
  associatedtype Cell: GridCell

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

public protocol GridCell: Blankable, Sendable, Equatable, Hashable {

}

public protocol Blankable {
  static func createBlank() -> Self
//  var isBlank: Bool { get }
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
