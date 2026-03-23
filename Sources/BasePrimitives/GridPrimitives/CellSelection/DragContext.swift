//
//  DragContext.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/3/2026.
//

struct DragContext {

  /// This is ``GridDragEvent/start``
  /// Should be captured once at the beginning of the event
  let anchor: GridPosition
//  let event: GridDragEvent

  /// Any Cells selected at the beginning of the event
  var base: Set<GridPosition>

  /// The dimensions the Drag event is occuring within
  var dimensions: GridDimensions

  /// Based on the modifier keys held by the user at event start
//  var mode: CellSelectionMode

  init(
    anchor: GridPosition,
//    for event: GridDragEvent,
    currentSelection base: Set<GridPosition>,
    dimensions: GridDimensions,
//    mode: CellSelectionMode,
  ) {
    self.anchor = anchor
//    self.event = event
    self.base = base
    self.dimensions = dimensions
//    self.mode = mode
  }
}
