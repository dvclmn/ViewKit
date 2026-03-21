//
//  CellSelectionCanvas.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/2/2026.
//

import BasePrimitives
import CanvasKit
import GraphicsKit
import SwiftUI

extension GridCanvas {
  struct CellSelectionCanvas: View {
    @Environment(SelectionHandler.self) private var store
    @Environment(\.unitSize) private var unitSize
    @Environment(\.cornerRounding) private var cornerRounding
    @Environment(\.gridDimensions) private var gridDimensions
    @Environment(\.canvasBackground) private var canvasBackground
    @Environment(\.gridGeometry) private var gridGeometry
    @Environment(\.isShowingCellNumbers) private var isShowingCellNumbers
    @Environment(\.pointerGridPosition) private var pointerGridPosition
    @Environment(\.isCellSelectionEnabled) private var isCellSelectionEnabled

    private let rounding: CGFloat = 4

    var body: some View {

      Canvas(
        opaque: true,
        rendersAsynchronously: true
      ) { context, size in

        context.fillCanvas(with: canvasBackground, in: size)

        /// Grid Lines
        context.drawGrid(
          domain: .canvas,
          in: size,
          sizeMode: .fillContainer,
          pinMode: .canvas,
          drawsBorder: false
        )

        /// Selected Cells
        drawSelection(context)

        /// Hovered Cell rect
        drawHoverCell(context)

      }  // END canvas
      //      .onAppear { seedDebugSelectionIfNeeded() }

    }
  }

}

extension GridCanvas.CellSelectionCanvas {

  private func drawHoverCell(_ context: GraphicsContext) {
    guard isCellSelectionEnabled else { return }
    guard let rect = selectionRect,
      let gridDimensions,
      let hoverPos = pointerGridPosition
    else { return }

    let radii = rectRadii(
      dimensions: gridDimensions,
      position: hoverPos
    )

    let path = Path(roundedRect: rect, cornerRadii: radii)

    context.fillAndStroke(
      path,
      fillColour: .cyan.opacity(0.25),
      strokeColour: .blue.opacity(0.8),
      strokeThickness: 1
    )
  }

  private var selectionRect: CGRect? {
    guard let position = pointerGridPosition else { return nil }
    guard let cellSize = gridGeometry?.projection.unitSize else { return nil }

    let originX = CGFloat(position.column) * cellSize.width
    let originY = CGFloat(position.row) * cellSize.height
    return CGRect(
      x: originX, y: originY,
      width: cellSize.width,
      height: cellSize.height
    )
  }

  var canvasOffset: CGSize? {
    guard let unitSize else { return nil }
    let result = isShowingCellNumbers ? -unitSize : nil
    //    print("Canvas Offset: \(result?.displayString(.concise), default: "nil")")
    return result
  }

  private func rectRadii(
    dimensions: GridDimensions,
    position: GridPosition,
  ) -> RectangleCornerRadii {
    let rounding: CGFloat = cornerRounding ?? Styles.sizeTiny
    //    guard let gridDimensions else { return nil }
    //    guard let position = store.pointerGridPosition else { return nil }

    /// Determine if the current position is at any of the four grid corners.
    let isTop = position.row == 0
    let isLeft = position.column == 0
    let isBottom = position.isLastRow(in: dimensions)
    let isRight = position.isLastColumn(in: dimensions)

    /// Round only the corners that coincide with the grid's outer corners.
    let topLeading: CGFloat = (isTop && isLeft) ? rounding : .zero
    let topTrailing: CGFloat = (isTop && isRight) ? rounding : .zero
    let bottomLeading: CGFloat = (isBottom && isLeft) ? rounding : .zero
    let bottomTrailing: CGFloat = (isBottom && isRight) ? rounding : .zero

    return RectangleCornerRadii(
      topLeading: topLeading,
      bottomLeading: bottomLeading,
      bottomTrailing: bottomTrailing,
      topTrailing: topTrailing
    )
  }
}

// MARK: - Selection Rendering

extension GridCanvas.CellSelectionCanvas {

  private struct OutlineSegment: Hashable {
    let x1: Int
    let y1: Int
    let x2: Int
    let y2: Int

    init(_ x1: Int, _ y1: Int, _ x2: Int, _ y2: Int) {
      /// normalize so identical segments hash the same
      if x1 < x2 || (x1 == x2 && y1 < y2) {
        self.x1 = x1
        self.y1 = y1
        self.x2 = x2
        self.y2 = y2
      } else {
        self.x1 = x2
        self.y1 = y2
        self.x2 = x1
        self.y2 = y1
      }
    }
  }

  private func drawSelection(_ context: GraphicsContext) {
    guard isCellSelectionEnabled else { return }
    guard !store.selected.isEmpty else { return }
    guard let cellSize = gridGeometry?.projection.unitSize ?? unitSize else { return }

    /// Fill selected cells
    drawSelectionFill(
      context,
      selected: store.selected,
      cellSize: cellSize,
      color: .cyan.opacity(0.2)
    )

    /// Stroke outer outline with emphasis
    let outline = outlineSegments(from: store.selected)
    
    drawSelectionOutline(
      context,
      segments: outline,
      cellSize: cellSize,
      color: .blue.opacity(0.9),
      lineWidth: 2
    )
  }

  private func drawSelectionFill(
    _ context: GraphicsContext,
    selected: Set<GridPosition>,
    cellSize: CGSize,
    color: Color
  ) {
    for position in selected {
      let rect = CGRe
//      let rect = CGRect(
//        x: CGFloat(position.column) * cellSize.width,
//        y: CGFloat(position.row) * cellSize.height,
//        width: cellSize.width,
//        height: cellSize.height
//      )
      context.fill(Path(rect), with: .color(color))
    }
  }

  private func outlineSegments(from selected: Set<GridPosition>) -> Set<OutlineSegment> {
    var edges = Set<OutlineSegment>()
    for pos in selected {
      let c = pos.column
      let r = pos.row

      /// Four edges of the cell in lattice coordinates
      let top = OutlineSegment(c, r, c + 1, r)
      let bottom = OutlineSegment(c, r + 1, c + 1, r + 1)
      let left = OutlineSegment(c, r, c, r + 1)
      let right = OutlineSegment(c + 1, r, c + 1, r + 1)

      for e in [top, bottom, left, right] {
        if edges.contains(e) {
          
          /// shared edge -> internal -> cancel
          edges.remove(e)
        } else {
          edges.insert(e)
        }
      }
    }
    return edges
  }

  private func drawSelectionOutline(
    _ context: GraphicsContext,
    segments: Set<OutlineSegment>,
    cellSize: CGSize,
    color: Color,
    lineWidth: CGFloat
  ) {
    let style = StrokeStyle(lineWidth: lineWidth, lineCap: .square, lineJoin: .round)
    for e in segments {
      var p = Path()
      let p1 = CGPoint(x: CGFloat(e.x1) * cellSize.width, y: CGFloat(e.y1) * cellSize.height)
      let p2 = CGPoint(x: CGFloat(e.x2) * cellSize.width, y: CGFloat(e.y2) * cellSize.height)
      p.move(to: p1)
      p.addLine(to: p2)
      context.stroke(p, with: .color(color), style: style)
    }
  }
}
