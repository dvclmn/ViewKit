//
//  Model+GridPosition.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/7/2025.
//

import SwiftUI

/// Represents a position in a 2D Grid (rows and columns).
//public struct GridPosition: ModelBase {
//  public let column: Int
//  public let row: Int
//
//  public init(
//    column: Int,
//    row: Int,
//  ) {
//    precondition(row >= 0 && column >= 0, "GridPosition cannot be negative, in either dimension.")
//    self.column = column
//    self.row = row
//  }
//
//}

extension GridPosition {

  //  public static func createEdgePositions(
  //    edge: GridEdge,
  //    rowCount: Int,
  //    columnCount: Int
  //  ) -> [GridPosition] {
  //    switch edge {
  //      case .top:
  //        return createRow(0, columns: 0..<columnCount)
  //      case .bottom:
  //        return createRow(rowCount - 1, columns: 0..<columnCount)
  //      case .leading:
  //        return createColumn(0, rows: 0..<rowCount)
  //      case .trailing:
  //        return createColumn(columnCount - 1, rows: 0..<rowCount)
  //    }
  //  }

  //  public static func createRow(
  //    _ rowIndex: Int,
  //    columns: ClosedRange<Int>
  //  ) -> [GridPosition] {
  //    columns.map { GridPosition(column: $0, row: rowIndex) }
  //  }
  //
  //  public static func createColumn(
  //    _ columnIndex: Int,
  //    rows: ClosedRange<Int>
  //  ) -> [GridPosition] {
  //    rows.map { GridPosition(column: columnIndex, row: $0) }
  //  }

}


//extension GridPosition: CustomStringConvertible {
//  public var description: String {
//    """
//    GridPosition[X: \(column), Y: \(row)]
//    """
//  }
//}
