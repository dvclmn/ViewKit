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
  var modifiers: Modifiers { CellSelectionMode.modifiers(for: self) }
  init(fromModifiers modifiers: Modifiers) { self = CellSelectionMode.mode(for: modifiers) }

  static func modifiers(for mode: CellSelectionMode) -> Modifiers {
    switch mode {
      case .new: []
      case .add: [.command]
      case .subtract: [.option]
    }
  }

  static func mode(for modifiers: Modifiers) -> CellSelectionMode {
    switch modifiers {
      case [.command]: .add
      case [.option]: .subtract
      default: .new
    }
  }

}
