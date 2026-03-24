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

    //    var dragHandler: DragSelectionHandler = .init()
    var dragContext: DragContext?

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
        let anchor = event.start.clamped(to: dimensions)

        dragContext = .init(
          anchor: anchor,
          currentSelection: selected,
          //          dimensions: dimensions
        )

      case .changed:
        selected = updateDrag(event: event, dimensions: dimensions)

      case .ended, .none:
        let final = updateDrag(event: event, dimensions: dimensions)
        dragContext = nil
        selected = final

      default: break
    }
    //    switch event.phase {
    //      case .began:
    //        dragHandler.beginDrag(
    //          event: event,
    //          selected: selected,
    //          dimensions: dimensions
    //        )
    //      //        dragHandler.beginDragSelection(
    //      //          selected: selected,
    //      //          mode: mode,
    //      //          dimensions: dimensions
    //      //        )
    //      //        store.beginDragSelection()
    //      //        store.updateDragSelection(current: current)
    //
    //      case .changed:
    //        selected = dragHandler.updateDrag(event: event, mode: mode)
    //      //        dragHandler.updateDragSelection(current: <#T##Set<GridPosition>#>)
    //      //        store.updateDragSelection(current: current)
    //
    //      case .ended, .none:
    //        let final = dragHandler.endDrag(event: event, mode: mode)
    //        selected = final
    //        lastSelected = event.current.clamped(to: dimensions)
    //
    //      default:
    //        break
    //    }
  }

  private func updateDrag(
    event: GridDragEvent,
    dimensions: GridDimensions,
  ) -> Set<GridPosition> {
    guard let dragContext else { return [] }
    let current = event.current.clamped(to: dimensions)
    let rectPositions = positions(
      from: dragContext.anchor,
      to: current,
      clampedTo: dimensions
    )

    let selection = mode.apply(
      base: dragContext.base,
      current: Set(rectPositions)
    )

    return selection

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

  private func positions(
    from start: GridPosition,
    to current: GridPosition,
    clampedTo dimensions: GridDimensions? = nil
  ) -> [GridPosition] {

    let a = start.clampedIfNeeded(to: dimensions)
    let b = current.clampedIfNeeded(to: dimensions)

    let minCol = min(a.column, b.column)
    let minRow = min(a.row, b.row)
    let maxCol = max(a.column, b.column)
    let maxRow = max(a.row, b.row)
    let rect = GridRect(
      origin: .init(column: minCol, row: minRow),
      size: .init(
        width: maxCol - minCol + 1,
        height: maxRow - minRow + 1
      )
    )
    return rect.allPositions
  }
}
