//
//  Grid+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/11/2025.
//

extension GridShaped {

  /// Width of the first row — the 'intended' width of a rectangular grid.
  public var canonicalWidth: Int { cells.first?.count ?? 0 }
  
  /// This assumes a `maxWidth`(width of widest row).
  /// Use `canonicalWidth` for width of *first* row
  public var width: Int { maxWidth }

  /// Width of the widest row
  public var maxWidth: Int { cells.map(\.count).max() ?? 0 }
  public var height: Int { cells.count }
  
  public var isEmpty: Bool {
    cells.isEmpty || cells.allSatisfy { $0.isEmpty }
  }
  
  public var rows: [Row] { cells.map(\.self) }

  public mutating func expandToInclude(
    position: GridPosition,
    blank: @autoclosure () -> GridCell
  ) {
    let requiredRows = position.row + 1
    let requiredColumns = Swift.max(columnCount, position.column + 1)
    
    var newCells: [GridCell] = []
    
    for row in 0..<requiredRows {
      for column in 0..<requiredColumns {
        if row < rowCount, column < columnCount {
          let position = GridPosition(row: row, column: column)
          print("GridPosition from `expandToInclude()`: \(position)")
          guard let cell = self[at: position] else { return }
          newCells.append(cell)
        } else {
          newCells.append(blank())
        }
      }
    }
    
    self.cells = newCells
    self.columns = requiredColumns
    self.rows = requiredRows
  }
  
}

