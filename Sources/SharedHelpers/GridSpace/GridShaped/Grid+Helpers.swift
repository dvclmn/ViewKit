//
//  Grid+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/11/2025.
//

extension Grid.GridShaped {

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
  
  public var rows: [Self.Row] { cells.map(\.self) }

}
