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
  @Environment(\.hoverLocation) private var hoverLocation

  private let rounding: CGFloat = 4

  //  let drawingContext: @escaping (inout GraphicsContext, CGSize)

  var body: some View {

    Canvas(
      opaque: true,
      rendersAsynchronously: true
    ) {
      context,
      size in

      context.drawGrid(
        in: size,
        sizeMode: .fillContainer,
        pinMode: .canvas,
        lineColour: .gray.opacity(0.3),
        lineWidth: 1,
        annotations: .quarter,
        drawsBorder: false
      )

      guard let rect = store.selectionRect else {
        context.drawDebugText("No selection rect", at: size.midpoint, pointDisplay: .point(.pink))
        return
      }

      if let radii = rectRadii {
        let rounded = UnevenRoundedRectangle(cornerRadii: radii)
          .path(in: rect)
        context.fillAndStroke(
          rounded,
          fillColour: .cyan.opacity(0.25),
          strokeColour: .blue.opacity(0.8),
          strokeThickness: 1
        )
      } else {
        let selectedShape = Path(rect)
        context.fillAndStroke(
          selectedShape,
          fillColour: .cyan.opacity(0.25),
          strokeColour: .blue.opacity(0.8),
          strokeThickness: 1
        )
      }

    }  // END canvas

    .addInfoBarItems {
      //      Labeled("Pointer (Global)", value: store.pointerLocation?.displayString(.location))
      //      Labeled("Pointer (Local)", value: store.pointerLocalSpace?.displayString(.location))
      //      Labeled("Viewport Rect", value: viewportRect?.displayString(.concise))
      //      Labeled("Cell Size", value: unitSize?.displayString(.dimensions))
      //      Labeled("Zoom", value: zoomLevel.toPercentString(within: zoomRange ?? .unitRange))
      Labeled("Canvas Size", value: canvasSize?.displayString(.dimensions))
    }
    //    .debugTextOverlay("No zoom range in env", isEnabled: zoomRange == nil, alignment: .center)

    .task(id: panOffset) { store.pan = panOffset }
    .task(id: zoomLevel) { store.zoom = zoomLevel }
    .task(id: viewportRect) { refreshGeometry() }
    .task(id: unitSize) { refreshGeometry() }
    .task(id: gridDimensions) { refreshGeometry() }
    .task(id: hoverLocation) { store.pointerLocation = hoverLocation }

  }
}

extension CellSelectionCanvas {

  private func refreshGeometry() {
    guard let viewportRect, let unitSize, let gridDimensions else {
      store.geometry = nil
      return
    }

    store.geometry = GridGeometry(
      viewportRect: viewportRect,
      dimensions: gridDimensions,
      projection: GridProjection(unitSize: unitSize),
      anchor: .center
        //      canvasAnchor: .center
    )
  }

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
