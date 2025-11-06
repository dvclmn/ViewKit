//
//  Grid+Subscripts.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/11/2025.
//

extension GridShaped {

  public subscript(row rowIndex: Int, col colIndex: Int) -> Cell? {
    get { cells[safe: rowIndex]?[safe: colIndex] }
    set {
      guard let newValue,
        cells.indices.contains(rowIndex),
        cells[rowIndex].indices.contains(colIndex)
      else { return }
      cells[rowIndex][colIndex] = newValue
    }
  }

  public subscript(row rowIndex: Int) -> Row {
    get { cells[safe: rowIndex] ?? [] }
    set {
      if rowIndex < cells.count {
        cells[rowIndex] = newValue

      } else if rowIndex == cells.count {
        cells.append(newValue)
      }
    }
  }

  //  public subscript(col colIndex: Int) -> Row? {
  //
  //    get { self[safe: row] ?? [] }
  //    set {
  //      if row < self.count {
  //        self[row] = newValue
  //
  //      } else if row == self.count {
  //        self.append(newValue)
  //      }
  //    }
  //  }

}
