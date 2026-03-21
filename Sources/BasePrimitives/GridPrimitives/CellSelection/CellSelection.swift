//
//  CellSelection.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/3/2026.
//

import Foundation

extension GridCanvas {
  
  public struct CellSelection {
    private(set) var selected: Set<GridPosition> = []
    public var lastSelected: GridPosition?
    
    public var cellSize: CGSize?
    public var modifiers: Modifiers = []
    
  }
}

extension GridCanvas.CellSelection {
  
  mutating func updateModifiers(_ modifiers: Modifiers) {
    self.modifiers = modifiers
  }
  
  mutating func updateCellSize(_ size: CGSize?) {
    self.cellSize = size
  }
  
  func selectedCells(in grid: Grid) -> [Grid.Cell] {
    selected.compactMap { grid[at: $0] }
    
    //    canvas.artwork[at: position]
    //    let cells: Artwork.Cells
    //    for position in selectedCellPositions {
    //      guard let newCell = canvas.artwork[at: position] else { continue }
    //
    //    }
    //    canvas.artwork.cells.filter { cell in
    ////      let pos = canvas.artwork[<#T##position: Int##Int#>]
    //      selectedCellPositions.contains(cell.)
    ////      selectedCellPositions.contains($0.position)
    //    }
    
  }
  
  mutating func selectAll(in grid: Grid) {
    fatalError("Need to fix")
    //    let allPositions = gridCanvas.artwork.positions
    //    self.replace(with: allPositions)
  }
  
  mutating func add(_ positions: [GridPosition]) {
    selected.formUnion(positions)
    lastSelected = positions.last
  }
  
  mutating func subtract(_ positions: [GridPosition]) {
    selected.subtract(positions)
    lastSelected = positions.last
  }
  
  mutating func replace(with newPositions: [GridPosition]) {
    selected = Set(newPositions)
    lastSelected = newPositions.last
  }
  
  mutating func clear() {
    selected.removeAll()
    lastSelected = nil
  }
  
  mutating func moveCellSelection(
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
  //  mutating func applySelection(
  //    position: GridPosition,
  //    cellSize: CGSize,
  //  ) {
  //    self.applySelection(
  //      positions: [position],
  //      cellSize: cellSize,
  //    )
  //  }
  
  //  mutating func applySelection(
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
  
  mutating func handleSelection(
    forMode mode: CellSelectionMode,
    _ positions: [GridPosition],
  ) {
    switch mode {
      case .new:
        replace(with: positions)
        
      case .add:
        add(positions)
        
      case .subtract:
        subtract(positions)
    }
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
