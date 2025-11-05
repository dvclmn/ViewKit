//
//  PositionContext.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 5/11/2025.
//

extension Box {
  public struct PositionContext: Sendable {
    var rowIndex: Int
    var totalRows: Int
    public init(
      i rowIndex: Int,
      rowCount totalRows: Int
    ) {
      self.rowIndex = rowIndex
      self.totalRows = totalRows
    }
  }
}
