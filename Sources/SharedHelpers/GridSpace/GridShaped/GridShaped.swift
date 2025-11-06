//
//  GridRepresentible.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/11/2025.
//

import Foundation

public protocol GridShaped: Collection, ExpressibleByArrayLiteral {
  associatedtype Cell
  typealias Cells = [[Cell]]
  typealias Row = [Cell]
  var cells: Cells { get set }

  /// See `StringKit/StringStack` for example init
  init(_ cells: Cells)

  static func repair(row: Row, targetWidth: Int, fill: Cell) -> Row
  static var fallbackCell: Cell { get }
}

public enum RowValidation<T: GridShaped> {
  //  case patch(visualDebug: Bool = false)
  case patch((T.Row, Int) -> T.Row)
  case ignore
  case throwError
}

extension GridShaped {
  /// Creates a Grid with validated rows
  public static func create(
    _ cells: Cells,
    fallback: Self.Cell = Self.fallbackCell
  ) -> Self {

    let patched = Self.patchedGrid(cells) { row, targetWidth in
      Self.repair(row: row, targetWidth: targetWidth, fill: fallback)
    }

    return Self(patched ?? [])
  }
}
