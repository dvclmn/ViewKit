//
//  Model+CellSelectionMode.swift
//  DrawString
//
//  Created by Dave Coleman on 11/1/2026.
//

import Foundation

public enum CellSelectionMode: Sendable, Equatable {
  /// Replace a Cell selection with a new one
  case new

  /// Add Cells to selection
  case add

  /// Remove Cells from selection
  case subtract

}

extension CellSelectionMode {
  public var name: String {
    switch self {
      case .new: "New"
      case .add: "Add"
      case .subtract: "Subtract"
    }
  }
}

extension CellSelectionMode {
  
  func apply(
    base: Set<GridPosition>,
    current: Set<GridPosition>
  ) -> Set<GridPosition> {
    switch self {
      case .new: current
      case .add: base.union(current)
      case .subtract: base.subtracting(current)
    }
  }
  
}
