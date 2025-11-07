//
//  GridRepresentible.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/11/2025.
//

import Foundation

extension Grid {
  public protocol GridShaped: Collection, ExpressibleByArrayLiteral where Self.Element == Self.Row {
    associatedtype Cell
    typealias Cells = [[Cell]]
    typealias Row = [Cell]
    var cells: Cells { get set }
    
    init(_ cells: Cells)
    
//    static var normaliser: RowNormaliser<Self> { get }
      static func normaliseRows(
        _ cells: Cells,
        padCell: Cell,
        truncationCell: Cell?
      ) -> Cells
  }
}


//public enum RowValidation<T: GridShaped> {
//  case patch((T.Row, Int) -> T.Row)
//  case ignore
//  case throwError
//}
