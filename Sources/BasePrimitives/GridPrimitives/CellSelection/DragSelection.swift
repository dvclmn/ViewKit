//
//  DragSelection.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/3/2026.
//

/// Hold the base selection for the current drag
private struct DragContext {
  var base: Set<GridPosition>
}

struct DragSelectionHandler {
  private var dragContext: DragContext?
}

extension DragSelectionHandler {

  /// Called on `InteractionPhase/began`
  public mutating func beginDragSelection(
    selected: Set<GridPosition>
  ) {
    dragContext = DragContext(base: selected)
  }

  /// Called on `InteractionPhase/changed`, and on `ended` before clearing
  /// Note: `lastSelected` is not updated here, only on end.
  public mutating func updateDragSelection(
    current: Set<GridPosition>,
    mode: CellSelectionMode,
    selected: inout Set<GridPosition>
  ) {
    let base = dragContext?.base ?? []
    selected = combinedSelection(base: base, current: current, mode: mode)
  }

  /// Called on `InteractionPhase/ended`
  public mutating func endDragSelection(
    current: Set<GridPosition>
  ) {
    updateDragSelection(current: current)
    //    lastSelected = current.last
    dragContext = nil
  }

  /// Drag helper that encodes the mode semantics for a drag preview
  private mutating func combinedSelection(
    base: Set<GridPosition>,
    current: Set<GridPosition>,
    mode: CellSelectionMode
  ) -> Set<GridPosition> {
    switch mode {
      case .new: current
      case .add: base.union(current)
      case .subtract: base.subtracting(current)
    }
  }

}
