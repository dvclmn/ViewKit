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

  init(_ cells: Cells, rowValidation: RowValidation<Self>)
}

public enum RowValidation<T: GridShaped> {
  case patch((T.Row, Int) -> T.Row, visualDebug: Bool = false)
  case ignore
  case throwError
}

extension GridShaped {
//  public init(
//    _ cells: Cells,
//    rowValidation: RowValidation<Self> = .ignore
//  ) {
//    Self.init(cells, rowValidation: rowValidation)
//  }
  
//  public init(
//    _ cells: Cells,
//    rowValidation: RowValidation<Self> = .ignore
//  ) {
//    switch rowValidation {
//      case .patch(let strategy, let shouldDebug):
//        let patched =
//          Self.patchedGrid(
//            cells,
//            visualDebug: shouldDebug,
//            repair: strategy
//          ) ?? []
//        self.cells = patched
//
//      case .ignore:
//        self.cells = cells
//
//      case .throwError:
//        let canonicalWidth = cells.first?.count ?? 0
//        precondition(
//          cells.allSatisfy { $0.count == canonicalWidth },
//          "Non-rectangular StringStack: all rows must have equal width"
//        )
//        self.cells = cells
//    }
//  }
}
