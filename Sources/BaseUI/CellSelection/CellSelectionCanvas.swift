//
//  CellSelectionCanvas.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/2/2026.
//

import BasePrimitives
import GraphicsKit
import SwiftUI

struct CellSelectionCanvas: View {
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

      // MARK: - Grid Lines
      context.drawGrid(
        domain: .canvas,
        in: size,
        sizeMode: .fillContainer,
        pinMode: .canvas,
        drawsBorder: false
      )

      drawSelectionBox(context)

    }  // END canvas
//    .onCanvasTap { point in
//      
//    }
  }
}

extension CellSelectionCanvas {

  private func drawSelectionBox(_ context: GraphicsContext) {
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
