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

public protocol GridShaped: Collection, ExpressibleByArrayLiteral where Element == Row, Index == Int {
  associatedtype Cell: GridCell
  typealias Cells = [[Cell]]
  typealias Row = [Cell]

  var cells: Cells { get set }

  init(cells: Cells)
  init(_ cells: Cells)

  static func normalisedRows(
    _ cells: Cells,
    alignment: GridAlignment,
    paddingCell: Cell,
    truncationCell: Cell?
  ) -> Cells
}

public protocol GridCell: Equatable {
  //public protocol GridCell<Base>: Equatable {
  //  associatedtype Base: GridShaped
  //  var base: Grid { get }
  static func createBlank() -> Self
  //  func position() -> GridPosition
  //  func position(in grid: Self) -> GridPosition
}

extension GridShaped {
  public init(arrayLiteral elements: Row...) {
    self.init(elements)
  }
}

extension GridShaped {
  public init(_ cells: Self.Cells) {
    self.init(cells: cells)
  }
}

//public enum RowValidation<T: GridShaped> {
//  case patch((T.Row, Int) -> T.Row)
//  case ignore
//  case throwError
//}
