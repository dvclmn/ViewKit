//
//  CellSelection.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/3/2026.
//

import Foundation

// Hold the base selection for the current drag
private struct DragContext {
  var base: Set<GridPosition>
}

extension GridCanvas {

  @Observable
  public final class SelectionHandler {

    private(set) public var selected: Set<GridPosition> = []
    public var lastSelected: GridPosition?

    public var cellSize: CGSize?
    public var modifiers: Modifiers = []

    private var dragContext: DragContext?

    public init() {}
  }
}

extension GridCanvas.SelectionHandler {

  // Call this on .began
  public func beginDragSelection() {
    dragContext = DragContext(base: selected)
  }

  // Call this on .changed (and also on .ended before clearing)
  public func updateDragSelection(current: Set<GridPosition>) {
    let base = dragContext?.base ?? []
    selected = combinedSelection(base: base, current: current, mode: mode)
    // Do NOT update lastSelected here; we only want that on end.
  }

  // Call this on .ended
  public func endDragSelection(current: Set<GridPosition>) {
    updateDragSelection(current: current)
    //    lastSelected = current.last
    dragContext = nil
  }

  // Pure helper that encodes the mode semantics for a preview
  private func combinedSelection(
    base: Set<GridPosition>,
    current: Set<GridPosition>,
    mode: CellSelectionMode
  ) -> Set<GridPosition> {
    switch mode {
      case .new: return current
      case .add: return base.union(current)
      case .subtract: return base.subtracting(current)
    }
  }

  public var mode: CellSelectionMode { .init(fromModifiers: modifiers) }

  public func handleSelection(_ positions: [GridPosition]) {
    switch mode {
      case .new: replace(with: positions)
      case .add: add(positions)
      case .subtract: subtract(positions)
    }
  }

  public func updateCellSize(_ size: CGSize?) {
    self.cellSize = size
  }

  func selectedCells(in grid: Grid) -> [Grid.Cell] {
    selected.compactMap { grid[at: $0] }
  }

  public func selectAll(in grid: Grid) {
    self.replace(with: grid.allPositions)
  }

  func add(_ positions: [GridPosition]) {
    selected.formUnion(positions)
    lastSelected = positions.last
  }

  func subtract(_ positions: [GridPosition]) {
    selected.subtract(positions)
    lastSelected = positions.last
  }

  func replace(with newPositions: [GridPosition]) {
    selected = Set(newPositions)
    lastSelected = newPositions.last
  }

  func clearSelection() {
    selected.removeAll()
    lastSelected = nil
  }

  public func moveCellSelection(
    _ direction: Direction,
    by delta: Int = 1,
    in gridDimensions: GridDimensions,
  ) {
    guard let position = lastSelected else { return }
    let newPosition = position.moved(
      in: direction,
      by: delta,
      gridDimensions: gridDimensions,
    )
    self.replace(with: [newPosition])
  }

  /// `applySelection` methods turned off whilst waiting for `selectionStyle`
  /// and `CellSelectionInteraction` to be fixed
  //  func applySelection(
  //    position: GridPosition,
  //    cellSize: CGSize,
  //  ) {
  //    self.applySelection(
  //      positions: [position],
  //      cellSize: cellSize,
  //    )
  //  }

  //  func applySelection(
  //    positions: [GridPosition],
  //    cellSize: CGSize,
  //  ) {
  //    //    fatalError("Currently not implemented, waiting for Interaction API to clear up")
  //    let newPositions = selectionStyle.kind.resolvedPositions(
  //      newPositions: positions,
  //      lastSelected: lastSelected,
  //      cellSize: cellSize,
  //    )
  //    handleSelection(forMode: selectionStyle.mode, newPositions)
  //  }

}

//extension Interaction {
//  func resolvedPositions(
//    newPositions: [GridPosition],
//    lastSelected: GridPosition?,
//    cellSize: CGSize
//  ) -> [GridPosition] {
//    //    fatalError("Needs implementation after fixing up UnitRect 'positions'")
//    switch self {
//      case .rangeBetweenTaps:
//        guard let first = newPositions.first, let last = lastSelected else { return [] }
//        return UnitRect(from: last, to: first, unitSize: cellSize).gridPositions()
//
//      case .tap, .drag:
//        return newPositions
//      case .none: return []
//    }
//  }
//}

//  init(
//    from pointerPhase: PointerPhase?,
//    modifiers: Modifiers,
//    selectedCellsCount: Int
//  ) {
//    guard let pointerPhase else {
//      self = .none
//      return
//    }
//
//    let kind: InteractionKind
//    let isDragging = pointerPhase.isDrag
//    let isTapping = pointerPhase.isTap
//    switch (isDragging, isTapping, modifiers) {
//      case (false, true, _): kind = .tap
//      case (true, false, _): kind = .tapAndDrag
//      case (false, true, [.shift]) where selectedCellsCount > 0: kind = .rangeBetweenTaps
//      default: kind = .none
//    }
//    self = kind
//  }
//  init(from pointerPhase: PointerPhase) {
//    switch tapDragPhase {
//      case .drag(type: .marquee, _): .tapAndDrag
//      case .tap(_): .tap
//      case .ended: .
//    }
//  }
