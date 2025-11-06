//
//  Grid+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/11/2025.
//

extension GridShaped {

  /// Width of the first row — the 'intended' width of a rectangular grid.
  public var canonicalWidth: Int { cells.first?.count ?? 0 }

  /// Width of the widest row — useful for ragged or irregular data.
  public var maxWidth: Int { cells.map(\.count).max() ?? 0 }
  public var height: Int { cells.count }
  
  
  func cropped(toWidth width: Int) -> Self {
    Self(self.cells.map { Array($0.prefix(width)) })
  }
}
