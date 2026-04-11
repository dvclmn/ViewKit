//
//  Context+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/3/2026.
//

import BasePrimitives
import SwiftUI
import InteractionKit

extension GridLineContext {

  func makeOutput() -> GridLineOutput {
    return switch sizeMode {
      case .fixed, .fill: boundedGrid()
      case .fillContainer: infiniteGrid()
    }
  }
}

extension GridLineContext {

  var zoomedUnitSize: CGSize { unitSize * zoomLevel }
  var edgeEpsilon: CGFloat { max(0.5, effectiveLineWidth / 2) }
  var effectivePanOffset: CGSize { pinMode.isViewport ? -panOffset : .zero }

  var effectiveLineWidth: CGFloat {
    lineWidth.removingZoom(
      zoomLevel,
      across: zoomRange,
      sensitivity: 0.2
    )
  }
}

// MARK: - Path helpers
extension GridLineContext {

  func boundedGrid() -> GridLineOutput {
    let path = Path.boundedGrid(
      rect: gridRect,
      cellSize: zoomedUnitSize,
      containerSize: containerSize,
      drawsBorder: drawsBorder
    )

    return GridLineOutput(
      path: path,
      lineWidth: effectiveLineWidth,
      annotations: []
    )
  }

  func infiniteGrid() -> GridLineOutput {

    var markers: [GridLineAnnotation] = []

    /// Note: passing in *un-zoomed* cell (unit) size
    let path = Path.infiniteGrid(
      originOffset: gridRect.origin,
      containerSize: containerSize,
      cellSize: unitSize,
      offset: effectivePanOffset,
      drawsBorder: drawsBorder,
      edgeEpsilon: edgeEpsilon,
      onHorizontalIndex: { index, x in

        /// Passing `vertical` looks inverted, but it's not
        handleMarker(
          for: .vertical,
          at: index,
          position: x,
          markers: &markers
        )
      },
      onVerticalIndex: { index, y in

        /// Passing `horizontal` looks inverted, but it's not
        handleMarker(
          for: .horizontal,
          at: index,
          position: y,
          markers: &markers
        )
      }
    )

    return GridLineOutput(
      path: path,
      lineWidth: effectiveLineWidth,
      annotations: markers
    )
  }
}

extension GridLineContext {

  private func handleMarker(
    for axis: GeometryAxis,
    at index: Int,
    position: CGFloat,
    markers: inout [GridLineAnnotation]
  ) {

    /// Basing the offset on a square rather than the usual tall
    /// glyph shaped box make the numbers more balanced
    let offsetLength = unitSize.shortestDimension

    /// This adds a little extra height for the top row, also improves balance
    let offset = CGSize(width: offsetLength, height: offsetLength * 1.2)

    /// Removing `unitSize` at the end offsets the numbers to the
    /// left and up by one, so they don't overlap the Canvas content
    let baseOffset = (offset / 2) - offset
    let isVertical = axis.isVertical

    let valX =
      isVertical
      ? position + baseOffset.height / 2
      : baseOffset.width

    let valY =
      isVertical
      ? baseOffset.height
      : position + baseOffset.width

    markers.append(
      GridLineAnnotation(
        text: "\(index)",
        point: CGPoint(x: valX, y: valY)
      )
    )
  }
}
