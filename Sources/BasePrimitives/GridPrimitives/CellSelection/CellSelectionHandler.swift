//
//  CellSelection.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/3/2026.
//

import Foundation

extension GridCanvas {

  @Observable
  public final class SelectionHandler {

    private(set) public var selected: Set<GridPosition> = []
    public var lastSelected: GridPosition?

    public var cellSize: CGSize?
    public var modifiers: Modifiers = []

    var dragHandler: DragSelectionHandler = .init()

    public init() {}
  }
}

extension GridCanvas.SelectionHandler {

  public var mode: CellSelectionMode { .init(fromModifiers: modifiers) }

  public func handleTap(_ positions: [GridPosition]) {
    switch mode {
      case .new: replace(with: positions)
      case .add: add(positions)
      case .subtract: subtract(positions)
    }
  }

  public func handleDrag(
    _ event: GridDragEvent,
    dimensions: GridDimensions
  ) {
    //  public func handleDrag(_ positions: [GridPosition]) {

    switch event.phase {
      case .began:
        dragHandler.beginDragSelection(
          selected: selected,
          mode: mode,
          dimensions: dimensions
        )
      //        store.beginDragSelection()
      //        store.updateDragSelection(current: current)

      case .changed:
        dragHandler.updateDragSelection(current: <#T##Set<GridPosition>#>)
//        store.updateDragSelection(current: current)

      case .ended, .none:
        store.endDragSelection(current: current)

      default:
        break
    }

    // On pointer/drag began:
    //    dragHandler
    //    dragHandler.beginDragSelection(selected: selected)

    // On pointer/drag changed:
    let preview = dragHandler.updateDragSelection(current: currentPositions, mode: mode)
    selected = preview  // source of truth stays here

    // On pointer/drag ended:
    let final = dragHandler.endDragSelection(current: currentPositions, mode: mode)
    selected = final
    lastSelected = final.last

    //    switch mode {
    //      case .new: replace(with: positions)
    //      case .add: add(positions)
    //      case .subtract: subtract(positions)
    //    }
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
