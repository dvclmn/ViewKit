//
//  Grid+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/11/2025.
//

extension GridShaped {
  public var width: Int { cells.map { $0.count }.max() ?? 0 }
  public var height: Int { cells.count }
  
  /// Accesses or modifies the row of characters at the specified index.
  ///
  /// - Parameter row: The zero-based index of the row to access or modify.
  /// - Returns: The array of `Character` representing the row at the given index, or
  ///   an empty array if the index is out of bounds.
  ///
  /// - Note:
  ///   - If the getter is called with a row index greater than or equal to `height`,
  ///     it returns an empty array.
  ///   - If the setter is called with a row index less than `height`, it replaces the existing row.
  ///   - If the setter is called with a row index equal to `height`, it appends the new row at the end.
  ///   - Setting with a row index greater than `height` has no effect.

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
}
