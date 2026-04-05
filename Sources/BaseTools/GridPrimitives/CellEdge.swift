//
//  CellEdge.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/3/2026.
//

private struct CellEdge: Hashable {
  let cell: GridPosition
  let side: GridEdge

  init(cell: GridPosition, side: GridEdge) {
    switch side {
      case .top, .leading:
        self.cell = cell
        self.side = side
        
      case .bottom:
        self.cell = GridPosition(column: cell.column, row: cell.row + 1)
        self.side = .top
        
      case .trailing:
        self.cell = GridPosition(column: cell.column + 1, row: cell.row)
        self.side = .leading
    }
  }
}
