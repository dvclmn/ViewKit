//
//  CellSelection.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/2/2026.
//

import BasePrimitives
import CanvasKit
import LayoutKit
import SwiftUI

extension GridCanvas {
  public struct CellSelectionView<Content: View>: View {
    @Environment(SelectionHandler.self) private var store
    @Environment(\.unitSize) private var unitSize
    @Environment(\.gridDimensions) private var gridDimensions

    //    @State private var dragBaseSelection: Set<GridPosition> = []

    let content: () -> Content

    public init(@ViewBuilder content: @escaping () -> Content) {
      self.content = content
    }
    public var body: some View {

      @Bindable var store = store

      GridCanvasView {
        CellSelectionCanvas()
          .allowsCanvasClipping(false)

          .onGridDrag { event in
            handleDrag(event)
          }
          .onGridTap { position in
            store.handleSelection([position])
            //            store.selected.insert(position)

            print("Tapped cell: \(position)")
          }

        content()
      }

      .debugTextOverlay(alignment: .bottomLeading) {
        Labeled("Selection Mode", value: store.mode.name)
        //        Labeled("Selected", value: store.selected.map(\.description).joined(separator: ", "))
      }

      .environment(\.shouldShowInfoBarItems, true)

      .syncModifiers(to: $store.modifiers)
      .task(id: unitSize) { store.updateCellSize(unitSize) }
    }
  }
}

extension GridCanvas.CellSelectionView {
  private func handleDrag(_ event: GridDragEvent) {
    guard let dimensions = gridDimensions else { return }

    let clampedStart = event.start.clamped(to: dimensions)
    let clampedEnd = event.end.clamped(to: dimensions)
    //    let current = Set(positions(for: event))
    let current = Set(positions(from: clampedStart, to: clampedEnd))

    switch event.phase {
      case .began:
        store.beginDragSelection()
        store.updateDragSelection(current: current)

      case .changed:
        store.updateDragSelection(current: current)

      case .ended, .none:
        store.endDragSelection(current: current)

      default:
        break
    }
  }

  //  private func handleDrag(_ event: GridDragEvent) {
  //    //    .onGridDrag { origin, end in
  //    guard let dimensions = gridDimensions else { return }
  //    /// Optionally clamp when dragging outside bounds:
  //
  //    let origin = event.start
  //
  //    let a = origin.clamped(to: dimensions)
  //    let b = event.end.clamped(to: dimensions)
  //    //    let a = origin.clamped(to: dimensions.width, height: dimensions.height)
  //    //    let b = event.end.clamped(to: dimensions.width, height: dimensions.height)
  //
  //    let current = Set(positions(for: event))
  //
  //    switch event.phase {
  //      case .began:
  //        dragBaseSelection = store.selected
  //        applyPreview(base: dragBaseSelection, current: current)
  //
  //      case .changed:
  //        applyPreview(base: dragBaseSelection, current: current)
  //
  //      case .ended, .none:
  //        applyPreview(base: dragBaseSelection, current: current)
  //        dragBaseSelection.removeAll()
  //
  //      default:
  //        break
  //    }
  //    //    }
  //  }

  private func positions(from a: GridPosition, to b: GridPosition) -> [GridPosition] {
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

  //  func positions(for event: GridDragEvent) -> [GridPosition] {
  //    let a = event.start
  //    let b = event.end
  //    let minCol = min(a.column, b.column)
  //    let minRow = min(a.row, b.row)
  //    let maxCol = max(a.column, b.column)
  //    let maxRow = max(a.row, b.row)
  //    let rect = GridRect(
  //      origin: .init(column: minCol, row: minRow),
  //      size: .init(width: maxCol - minCol + 1, height: maxRow - minRow + 1)
  //    )
  //    return rect.allPositions
  //  }

  //  private func applyPreview(base: Set<GridPosition>, current: Set<GridPosition>) {
  //    store.handleSelection(current)
  //    switch store.mode {
  //      case .new:
  //        store.replace(with: Array(current))
  //      case .add:
  //        store.selected = base.union(current)
  //      case .subtract:
  //        store.selected = base.subtracting(current)
  //    }
  //  }

  //  func positions(for event: GridDragEvent) -> [GridPosition] {
  //    //  func positions(in origin: GridPosition, to end: GridPosition) -> [GridPosition] {
  //    let origin = event.start
  //    let end = event.end
  //    let minCol = min(origin.column, end.column)
  //    let minRow = min(origin.row, end.row)
  //    let maxCol = max(origin.column, end.column)
  //    let maxRow = max(origin.row, end.row)
  //
  //    let rect = GridRect(
  //      origin: .init(column: minCol, row: minRow),
  //      size: .init(width: maxCol - minCol + 1, height: maxRow - minRow + 1)
  //    )
  //    return rect.allPositions
  //  }
}
