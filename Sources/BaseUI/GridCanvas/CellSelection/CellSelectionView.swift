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

            print("Tapped cell: \(position)")
          }

        content()
      }

      .debugTextOverlay(alignment: .bottomLeading) {
        Labeled("Selection Mode", value: store.mode.name)
        Labeled("Selected Cells", value: store.selected.count)
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
