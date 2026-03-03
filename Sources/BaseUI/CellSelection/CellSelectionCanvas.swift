//
//  CellSelectionCanvas.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/2/2026.
//

import CoreTools
import GraphicsKit
import SwiftUI

struct CellSelectionCanvas: View {
  @Environment(SelectionHandler.self) private var store
  @Environment(\.unitSize) private var unitSize
  @Environment(\.panOffset) private var panOffset
  @Environment(\.zoomLevel) private var zoomLevel
  @Environment(\.zoomRange) private var zoomRange
  @Environment(\.viewportRect) private var viewportRect
  @Environment(\.cornerRounding) private var cornerRounding
  @Environment(\.gridDimensions) private var gridDimensions
  @Environment(\.canvasSize) private var canvasSize
  @Environment(\.pointerLocation) private var pointerLocation
  @Environment(\.canvasBackground) private var canvasBackground
  @Environment(\.isDebugMode) private var isDebugMode
  @Environment(\.gridGeometry) private var gridGeometry

  @Environment(\.gridLineColour) private var gridLineColour
  @Environment(\.gridLineWidth) private var gridLineWidth

  private let rounding: CGFloat = 4

  var body: some View {

    Canvas(
      opaque: true,
      rendersAsynchronously: true
    ) {
      context,
      size in

      context.fillCanvas(with: canvasBackground, in: size)

      context.drawGrid(
        domain: .canvas,
        //        unitSizeOverride: unitSize,
        in: size,
        sizeMode: .fillContainer,
        pinMode: .canvas,
        //        lineColour: gridLineColour,
        //        lineWidth: gridLineWidth,
        //        annotations: .full,
        drawsBorder: false
      )

      guard let rect = store.selectionRect else { return }

      let selectionShape: Path
      if let radii = rectRadii {
        selectionShape = UnevenRoundedRectangle(cornerRadii: radii)
          .path(in: rect)
      } else {
        selectionShape = Path(rect)
      }

      context.fillAndStroke(
        selectionShape,
        fillColour: .cyan.opacity(0.25),
        strokeColour: .blue.opacity(0.8),
        strokeThickness: 1
      )

    }  // END canvas
    .debugFrame("Cell Canvas", .orange, isEnabled: isDebugMode)
    .addInfoBarItems {
      //      Labeled("Pointer (Global)", value: store.pointerLocation?.displayString(.location))
      //      Labeled("Pointer (Local)", value: store.pointerLocalSpace?.displayString(.location))
      //      Labeled("Viewport Rect", value: viewportRect?.displayString(.concise))
      //      Labeled("Cell Size", value: unitSize?.displayString(.dimensions))
      //      Labeled("Zoom", value: zoomLevel.toPercentString(within: zoomRange ?? .unitRange))
      Labeled("Canvas Size", value: canvasSize?.cgSize.displayString(.dimensions))
    }

    .task(id: panOffset) { store.pan = panOffset }
    .task(id: zoomLevel) { store.zoom = zoomLevel }
    .task(id: pointerLocation) { store.pointerLocation = pointerLocation }
    .task(id: gridGeometry) { store.geometry = gridGeometry }

  }
}

extension CellSelectionCanvas {

  private var rectRadii: RectangleCornerRadii? {
    let rounding: CGFloat = cornerRounding ?? Styles.sizeTiny
    guard let gridDimensions else { return nil }
    guard let position = store.pointerGridPosition else { return nil }

    /// Determine if the current position is at any of the four grid corners.
    let isTop = position.row == 0
    let isLeft = position.column == 0
    let isBottom = position.isLastRow(in: gridDimensions)
    let isRight = position.isLastColumn(in: gridDimensions)

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
