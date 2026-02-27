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
  associatedtype Cell: BlankCreatable & Equatable
//  associatedtype Cell: GridCell
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

public protocol BlankCreatable {
  static func createBlank() -> Self
}

//extension Character: BlankCreatable {
//  public static func createBlank() -> Character { Character(" ") }
//}
//
//extension GridShaped where Cell: BlankCreatable {
//  // Now you can use Cell.createBlank() generically
//}
//public protocol GridCell: Equatable {
//  static func createBlank() -> Self
//}

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
