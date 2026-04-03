//
//  CellSelection.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/3/2026.
//

import Foundation
import InteractionKit

@Observable
public final class CellSelectionHandler<Grid: GridShaped> {

  private(set) public var selected: Set<GridPosition> = []
  public var lastSelected: GridPosition?

  public var cellSize: CGSize?
  public var modifiers: Modifiers = []
  private var gesture: SelectionGesture?

  var dragContext: DragContext?

  public init() {}
}

extension CellSelectionHandler {
  
  private var debugString: String {
    DisplayString {
      Labeled("Drag Context", value: dragContext)
    }.text
  }

  private var mode: CellSelectionMode? {
    guard let gesture else { return nil }
    return .init(modifiers: modifiers, gesture: gesture)
  }
  //  public func mode(using gesture: SelectionGesture) -> CellSelectionMode {
  //    .init(modifiers: modifiers, gesture: gesture)
  //  }
  
  public func handleTap(_ positions: [GridPosition]) {
    self.gesture = .tap
    defer { self.gesture = nil }
    applyMode(positions)
  }

  public func handleDrag(
    _ event: GridDragEvent,
    dimensions: GridDimensions
  ) {
    self.gesture = .drag

    ensureDragContext(for: event, dimensions: dimensions)

    switch event.phase {
      case .began, .changed:
        selected = updateDrag(event: event)

      case .ended, .none:
        selected = updateDrag(event: event)
        dragContext = nil
        gesture = nil

      default: break
    }
  }

  /// Lazily creates drag context on first event of a gesture.
  /// Handles the case where `.began` is never delivered (e.g. SwiftUI's
  /// DragGesture only provides `.changed` and `.ended`).
  private func ensureDragContext(
    for event: GridDragEvent,
    dimensions: GridDimensions
  ) {
    guard dragContext == nil, let mode else { return }
    let anchor = event.start.clamped(to: dimensions)
    dragContext = .init(
      anchor: anchor,
      currentSelection: selected,
      dimensions: dimensions,
      mode: mode
    )
  }

  private func updateDrag(event: GridDragEvent) -> Set<GridPosition> {
    guard let dragContext, let mode else { return [] }
    let current = event.current.clamped(to: dragContext.dimensions)

    let rectPositions = positions(
      from: dragContext.anchor,
      to: current,
      clampedTo: dragContext.dimensions
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

}

// MARK: - Set operations
extension CellSelectionHandler {

  /// Apply selection based on the provided mode
  func applySelection(
    for mode: CellSelectionMode,
    _ positions: [GridPosition]
  ) {
    let new = mode.apply(base: selected, current: positions)
    selected = new
    lastSelected = positions.last
  }

  /// Apply selection based on the current active mode
  func applyMode(_ positions: [GridPosition]) {
    guard let mode else { return }
    applySelection(for: mode, positions)
  }

  public func selectAll(in grid: Grid) {
    applySelection(for: .new, grid.size.allPositions)
    //    self.replace(with: grid.size.allPositions)
  }

  func clearSelection() {
    selected.removeAll()
    lastSelected = nil
  }
}

//  func replace(with positions: [GridPosition]) {
//
//    //    selected = Set(positions)
//    lastSelected = positions.last
//  }
//
//  func add(_ positions: [GridPosition]) {
//    selected.formUnion(positions)
//    lastSelected = positions.last
//  }
//
//  func subtract(_ positions: [GridPosition]) {
//    selected.subtract(positions)
//    lastSelected = positions.last
//  }
//
//  func toggle(_ position: GridPosition) {
//    selected.toggleMembership(of: position)
//    //    selected.subtract(positions)
//    //    lastSelected = positions.last
//  }

extension CellSelectionHandler {
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
    self.applySelection(for: .new, [newPosition])
    //    self.replace(with: [newPosition])
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
