//
//  GridLines+Draw.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import BasePrimitives
import SwiftUI

extension GraphicsContext {

  public func drawGrid(
    unitSizeOverride: CGSize? = nil,
    in containerSize: CGSize,
    sizeMode: GridSizeMode = .fillContainer,
    pinMode: GridPinMode = .canvas,
    lineColour: Color = .gray.opacity(0.2),
    lineWidth: CGFloat = 1,
    annotations: GridAnnotationDensity = .none,
    drawsBorder: Bool = true
  ) {

    guard let cellSize = (unitSizeOverride ?? self.environment.activeUnitSize)
    else { return }

    let zoom = self.environment.zoomLevel
    let zoomRange = self.environment.zoomRange
    let cellZoomed = cellSize * zoom
    let effectiveLineWidth: CGFloat = lineWidth.removingZoom(
      zoom,
      clampedTo: zoomRange?.toCGFloatRange,
      sensitivity: 0.2
    )

    guard
      let gridDimensions = sizeMode.gridDimensions(
        from: cellZoomed,  // Or `cellSize`?
        in: containerSize
      )
    else { return }

    let path: Path

    switch sizeMode {
      case .fixed, .fill:
        path = .boundedGrid(
          dimensions: gridDimensions,
          cellSize: cellZoomed,
          containerSize: containerSize,
          drawsBorder: drawsBorder
        )

      case .fillContainer:
        let panEnv = self.environment.panOffset
        let effectivePanOffset = pinMode == .viewport ? -panEnv : .zero

        path = .infiniteGrid(
          containerSize: containerSize,
          cellSize: cellSize,
          offset: effectivePanOffset,
          drawsBorder: drawsBorder,
          edgeEpsilon: max(0.5, lineWidth / 2),
          onVerticalIndex: { i, x in
            if annotations.isShowingCellMarkers {
              self.draw(
                Text("\(i)").font(.caption2).foregroundColor(.secondary),
                at: CGPoint(x: x + 4, y: 20))
            }
          }
        )
    }

    self.stroke(path, with: .color(lineColour), lineWidth: effectiveLineWidth)
  }

  private func drawAnnotation(_ text: String, at point: CGPoint) {
    self.draw(Text(text).font(.caption2).foregroundColor(.secondary), at: point)
  }
}
