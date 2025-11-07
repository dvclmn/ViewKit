//
//  GridRepresentible.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/11/2025.
//

import Foundation

public protocol GridShaped: Collection, ExpressibleByArrayLiteral where Self.Element == Self.Row {
  associatedtype Cell
  typealias Cells = [[Cell]]
  typealias Row = [Cell]
  var cells: Cells { get set }

  init(_ cells: Cells)
  
  static func defaultRepair(
    _ cells: Cells,
    padCell: Cell,
    truncationCell: Cell?
  ) -> Cells

  static var fallbackCell: Cell { get }
}

public enum RowValidation<T: GridShaped> {
  case patch((T.Row, Int) -> T.Row)
  case ignore
  case throwError
}

extension GridShaped {
  public init(arrayLiteral elements: Self.Element...) {
    self.init(elements)
  }
}

//
//  /// Creates a Grid with validated rows
//  public static func create(
//    _ cells: Cells,
//    fallback: Self.Cell = Self.fallbackCell
//  ) -> Self {
//
//    let patched = Self.patchedGrid(cells) { row, targetWidth in
//      Self.repair(row: row, targetWidth: targetWidth, fill: fallback)
//    }
//
//    return Self(patched ?? [])
////    return Self(arrayLiteral: patched)
//  }
//}
