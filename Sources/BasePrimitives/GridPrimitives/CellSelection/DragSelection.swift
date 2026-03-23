//
//  DragSelection.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/3/2026.
//

struct DragSelectionHandler {
  private var dragContext: DragContext?

  init(dragContext: DragContext? = nil) {
    self.dragContext = dragContext
  }

  /// 1) Begin: capture base
  public mutating func beginDragSelection(
    selected: Set<GridPosition>,
    mode: CellSelectionMode,
    dimensions: GridDimensions
  ) {
    dragContext = DragContext(
      base: selected,
      mode: mode,
      dimensions: dimensions
    )
  }

  // 2) Update: compute preview (pure, returns a Set)
  public mutating func updateDragSelection(
    current: Set<GridPosition>,
    //    mode: CellSelectionMode
  ) -> Set<GridPosition> {
    let base = dragContext?.base ?? []
    return combinedSelection(base: base, current: current, mode: mode)
  }

  // 3) End: compute final, clear context, and return it
  public mutating func endDragSelection(
    current: Set<GridPosition>,
    //    mode: CellSelectionMode
  ) -> Set<GridPosition> {
    let finalSelection = updateDragSelection(current: current, mode: mode)
    dragContext = nil
    return finalSelection
  }

  //  private func combinedSelection(
  //    base: Set<GridPosition>,
  //    current: Set<GridPosition>,
  //    mode: CellSelectionMode
  //  ) -> Set<GridPosition> {
  //    switch mode {
  //      case .new: current
  //      case .add: base.union(current)
  //      case .subtract: base.subtracting(current)
  //    }
  //  }

  var clampedStart: GridPosition { start.clamped(to: dimensions) }
  var clampedEnd: GridPosition { end.clamped(to: dimensions) }

  private func positions(
    from a: GridPosition,
    to b: GridPosition
  ) -> [GridPosition] {
    let minCol = min(a.column, b.column)
    let minRow = min(a.row, b.row)
    let maxCol = max(a.column, b.column)
    let maxRow = max(a.row, b.row)
    let rect = GridRect(
      origin: .init(column: minCol, row: minRow),
      size: .init(width: maxCol - minCol + 1, height: maxRow - minRow + 1)
    )
    return rect.allPositions
  }
}

//struct DragSelectionHandler {
//  private var dragContext: DragContext?
//}
//
//extension DragSelectionHandler {
//
//  /// Called on `InteractionPhase/began`
//  public mutating func beginDragSelection(
//    selected: Set<GridPosition>
//  ) {
//    dragContext = DragContext(base: selected)
//  }
//
//  /// Called on `InteractionPhase/changed`, and on `ended` before clearing
//  /// Note: `lastSelected` is not updated here, only on end.
//  public mutating func updateDragSelection(
//    current: Set<GridPosition>,
//    mode: CellSelectionMode,
//    selected: inout Set<GridPosition>
//  ) {
//    let base = dragContext?.base ?? []
//    selected = combinedSelection(base: base, current: current, mode: mode)
//  }
//
//  /// Called on `InteractionPhase/ended`
//  public mutating func endDragSelection(
//    current: Set<GridPosition>
//  ) {
//    updateDragSelection(current: current)
//    //    lastSelected = current.last
//    dragContext = nil
//  }
//
//  /// Drag helper that encodes the mode semantics for a drag preview
//  private mutating func combinedSelection(
//    base: Set<GridPosition>,
//    current: Set<GridPosition>,
//    mode: CellSelectionMode
//  ) -> Set<GridPosition> {
//    switch mode {
//      case .new: current
//      case .add: base.union(current)
//      case .subtract: base.subtracting(current)
//    }
//  }
//
//}
