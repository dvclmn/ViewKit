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
  case patch((T.Row, Int) -> T.Row, visualDebug: Bool = false)
  case ignore
  case throwError
}

extension GridShaped {
  public static func create(
    _ cells: Cells,
    rowValidation: RowValidation<Self>
  ) -> Self {

    let patched = Self.patchedGrid(cells, visualDebug: true) { row, targetWidth in
      Self.repair(row: row, targetWidth: targetWidth, fill: fallbackCell)
    }

    return Self(patched ?? [])
  }

  //    guard let firstRow = cells.first else { return nil }
  //
  //    let targetWidth = firstRow.count
  //    guard cells.contains(where: { $0.count != targetWidth }) else {
  //      return nil
  //    }
  //
  //    if visualDebug {
  //      print("⚠️ Grid shape mismatch detected – applying patch:")
  //      print("Original: \(cells.map { "\($0)" }.joined(separator: " | "))")
  //    }
  //
  //    let patched = cells.map { row in
  //      row.count == targetWidth ? row : repair(row, targetWidth)
  //    }
  //
  //
  //
  //
  //    switch rowValidation {
  //      case .patch(let strategy, let shouldDebug):
  //        let patched =
  //        Self.repair(row: <#T##[Self.Cell]#>, targetWidth: <#T##Int#>, fill: <#T##Self.Cell#>)(
  //          cells,
  //          visualDebug: shouldDebug,
  //          repair: strategy
  //        ) ?? []
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

  //    let validated = Self.repair(row: <#T##[Self.Cell]#>, targetWidth: <#T##Int#>, fill: <#T##Self.Cell#>)
  //  }
  //  public init(_ cells: Cells, rowValidation: RowValidation<Self>) {
  //
  //  }
}
