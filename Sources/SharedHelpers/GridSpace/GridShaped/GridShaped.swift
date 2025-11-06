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
  init(_ cells: Cells, rowValidation: RowValidation<Self>)
}

public enum RowValidation<T: GridShaped> {
  case patch((T.Row, Int) -> T.Row, visualDebug: Bool = false)
  case ignore
  case throwError
}
