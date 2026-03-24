//
//  DragSelection.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/3/2026.
//

struct DragSelectionHandler {
  private var context: DragContext?
  
  init(dragContext: DragContext? = nil) {
    self.context = dragContext
  }
}

//extension DragSelectionHandler {
//  
//  public mutating func updateContext(
//    event: GridDragEvent,
//    dimensions: GridDimensions
//  ) {
//    
//  }
//
//  mutating func beginDrag(
//    event: GridDragEvent,
//    selected: Set<GridPosition>,
//    //    mode: CellSelectionMode,
////    dimensions: GridDimensions
//  ) {
//    
//    let anchor = event.start.clampedIfNeeded(to: context?.dimensions)
    
//    context = DragContext(
//      anchor: anchor,
//      currentSelection: selected,
//      dimensions: dimensions
//    )
    //    context = DragContext(anchor: anchor, base: selected, dimensions: dimensions, mode: mode)
//  }

  /// 1) Begin: capture base
  //  public mutating func beginDragSelection(
  //    selected: Set<GridPosition>,
  //    mode: CellSelectionMode,
  //    dimensions: GridDimensions
  //  ) {
  //    dragContext = DragContext(
  //      base: selected,
  //      mode: mode,
  //      dimensions: dimensions
  //    )
  //  }

  // 2) Update: compute preview (pure, returns a Set)
  //  public mutating func updateDragSelection(
  //    current: Set<GridPosition>,
  //    //    mode: CellSelectionMode
  //  ) -> Set<GridPosition> {
  //    let base = context?.base ?? []
  //    return combinedSelection(base: base, current: current, mode: mode)
  //  }

//  mutating func updateDrag(
//    event: GridDragEvent,
//    mode: CellSelectionMode
//  ) -> Set<GridPosition> {
//    guard let ctx = context else { return [] }
//    let current = event.current.clamped(to: ctx.dimensions)
////    let current = clamp(event.current, to: ctx.dimensions)
//    let rectPositions = positions(
//      from: ctx.anchor,
//      to: current,
//      clampedTo: ctx.dimensions
//    )
//    return mode.apply(base: ctx.base, current: Set(rectPositions))
//  }
  
//  mutating func endDrag(
//    event: GridDragEvent,
//    mode: CellSelectionMode
//  ) -> Set<GridPosition> {
//    let final = updateDrag(event: event, mode: mode)
//    context = nil
//    return final
//  }
  
//  mutating func updateDrag(
//    event: GridDragEvent,
//    mode: CellSelectionMode
//  ) -> Set<GridPosition> {
//    guard let ctx = context else { return [] }
//        let current = event.current.clamped(to: ctx.dimensions)
//    let rectPositions = positions(
//      from: ctx.anchor,
//      to: current,
//      clampedTo: ctx.dimensions
//    )
//    return mode.apply(base: ctx.base, current: Set(rectPositions))
//    //    let current = GridPosition(event.currentPoint, clampedTo: ctx.dimensions)
//    //    let rectPositions = positions(from: ctx.anchor, to: current, dimensions: ctx.dimensions)
//    //    return ctx.mode.apply(base: ctx.base, current: Set(rectPositions))
//  }

  // 3) End: compute final, clear context, and return it
//  mutating func endDrag(
//    event: GridDragEvent,
//    mode: CellSelectionMode
//  ) -> Set<GridPosition> {
//    let final = updateDrag(event: event, mode: mode)
//    //    let final = updateDragSelection(event: event)
//    context = nil
//    return final
//  }
  //  public mutating func endDragSelection(
  //    current: Set<GridPosition>,
  //    //    mode: CellSelectionMode
  //  ) -> Set<GridPosition> {
  //    let finalSelection = updateDragSelection(current: current, mode: mode)
  //    context = nil
  //    return finalSelection
  //  }

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

  //  var clampedStart: GridPosition { start.clamped(to: dimensions) }
  //  var clampedEnd: GridPosition { end.clamped(to: dimensions) }

  
//}

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
