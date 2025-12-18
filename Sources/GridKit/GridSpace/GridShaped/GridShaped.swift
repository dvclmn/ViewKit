//
//  GridRepresentible.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/11/2025.
//

import Foundation
import IdentifiedCollections

public protocol GridShaped: Collection, ExpressibleByArrayLiteral where Self.Element == Self.Row {
  associatedtype Cell
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
