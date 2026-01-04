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

  public subscript(row rowIndex: Int) -> Row? {
    get { cells[safe: rowIndex] }
    set { cells[safe: rowIndex] = newValue }
  }

  public subscript(column columnIndex: Int) -> [Cell] {
    get { cells.map(\.self[columnIndex]) }
    set {
      for i in cells.indices {
        cells[i][safe: columnIndex] = newValue[i]
      }
    }
    //    return cells.map { $0[columnIndex] }
  }

  //  public subscript(row rowIndex: Int) -> Row {
  //    get { self[at: GridPosition(<#T##row: Int##Int#>, <#T##column: Int##Int#>)] }
  ////    get { cells[safe: rowIndex] ?? [] }
  ////    set {
  ////      if rowIndex < cells.count {
  ////        cells[rowIndex] = newValue
  ////
  ////      } else if rowIndex == cells.count {
  ////        cells.append(newValue)
  ////      }
  ////    }
  //  }
  //
  //  public subscript(col colIndex: Int) -> [Cell] {
  //    get { self[row: <#T##Int#>] }
  ////    get { cells[safe: rowIndex] ?? [] }
  ////    set {
  ////      if rowIndex < cells.count {
  ////        cells[rowIndex] = newValue
  ////
  ////      } else if rowIndex == cells.count {
  ////        cells.append(newValue)
  ////      }
  ////    }
  //  }

  public subscript(at position: GridPosition) -> Cell? {
    get {
      guard isPositionValid(position) else { return nil }
      //      guard isValid(position: position) else { return nil }
      return self[row: position.row, col: position.column]
      //      return self[row: position.row, column: position.column]
    }
    set {
      guard isPositionValid(position) else { return }
      //      guard isValid(position: position), let value = newValue else { return }
      self[row: position.row, col: position.column] = newValue
      return
      //      self[row: position.row, column: position.column] = value
    }
  }

}
