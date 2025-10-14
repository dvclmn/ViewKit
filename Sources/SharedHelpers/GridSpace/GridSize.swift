//
//  GridSize.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/10/2025.
//

import Foundation

/// Equivalent to `CGSize`
public struct GridSize: Hashable, Codable {
  public var columns: GridLength
  public var rows: GridLength
  
  public init(
    columns: GridLength,
    rows: GridLength
  ) {
    self.columns = columns
    self.rows = rows
  }  
}

extension GridSize {
  public var screenSize: CGSize {
    CGSize(width: columns.screenLength, height: rows.screenLength)
  }
  
}
