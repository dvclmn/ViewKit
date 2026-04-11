//
//  GridLinesMode.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/4/2026.
//

public enum GridLinesMode {
  /// Draw enough lines to cover the container, choosing indices based on offset
  case infinite(offset: CGSize)
  
  /// Draw a fixed number of columns/rows starting at zero (no negative indices)
  case bounded(columns: Int, rows: Int)
}
