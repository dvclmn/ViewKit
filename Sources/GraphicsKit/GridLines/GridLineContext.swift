//
//  GridLineContext.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/3/2026.
//

import CoreTools
import SwiftUI

struct GridLineAnnotation {
  let text: String
  let point: CGPoint
}

struct GridLineOutput {
  let path: Path
//  let lineColour: Color
  let lineWidth: CGFloat
  let annotations: [GridLineAnnotation]
}

// MARK: - Main Context
struct GridLineContext {
  let unitSize: CGSize
  let containerSize: CGSize
  let sizeMode: GridSizeMode
  let pinMode: GridPinMode
//  let lineColour: Color
  let lineWidth: CGFloat
//  let annotationDensity: GridAnnotationDensity
  let drawsBorder: Bool
  let panOffset: CGSize
  let zoomLevel: CGFloat
  let zoomRange: ClosedRange<CGFloat>?
}

extension GridLineContext {
  init?(
    unitSizeOverride: CGSize?,
    containerSize: CGSize,
    sizeMode: GridSizeMode,
    pinMode: GridPinMode,
//    lineColour: Color,
    lineWidth: CGFloat,
//    annotationDensity: GridAnnotationDensity,
    drawsBorder: Bool,
    environment: EnvironmentValues
  ) {
    guard let unitSize = unitSizeOverride ?? environment.activeUnitSize else {
      return nil
    }

    self.unitSize = unitSize
    self.containerSize = containerSize
    self.sizeMode = sizeMode
    self.pinMode = pinMode
//    self.lineColour = lineColour
    self.lineWidth = lineWidth
//    self.annotationDensity = annotationDensity
    self.drawsBorder = drawsBorder
    self.panOffset = environment.panOffset
    self.zoomLevel = environment.zoomLevel.toCGFloat
    self.zoomRange = environment.zoomRange?.toCGFloatRange
  }
}

extension GridLineContext {

  var zoomedUnitSize: CGSize {
    unitSize * zoomLevel
  }

  var effectiveLineWidth: CGFloat {
    lineWidth.removingZoom(
      zoomLevel,
      clampedTo: zoomRange,
      sensitivity: 0.2
    )
  }

  var edgeEpsilon: CGFloat {
    max(0.5, effectiveLineWidth / 2)
  }

  var effectivePanOffset: CGSize {
    pinMode == .viewport ? -panOffset : .zero
  }

  func makeOutput() -> GridLineOutput? {
    switch sizeMode {
      case .fixed, .fill:
        guard
          let dimensions = sizeMode.gridDimensions(
            from: zoomedUnitSize,
            in: containerSize
          )
        else { return nil }

        let path = Path.boundedGrid(
          dimensions: dimensions,
          cellSize: zoomedUnitSize,
          containerSize: containerSize,
          drawsBorder: drawsBorder
        )

        return GridLineOutput(
          path: path,
//          lineColour: lineColour,
          lineWidth: effectiveLineWidth,
          annotations: []
        )

      case .fillContainer:
        var markers: [GridLineAnnotation] = []

        /// Note: passing in *un-zoomed* cell (unit) size
        let path = Path.infiniteGrid(
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
//          lineColour: lineColour,
          lineWidth: effectiveLineWidth,
          annotations: markers
        )
    }
  }

  private func handleMarker(
    for axis: GridAxis,
    at index: Int,
    position: CGFloat,
    markers: inout [GridLineAnnotation]
  ) {
//    guard shouldDrawMarker(for: index) else { return }

    let baseOffset = unitSize / 2
    let isVertical = axis.isVertical

    let valX = isVertical ? position + baseOffset.height / 2 : baseOffset.width
    let valY = isVertical ? baseOffset.height : position + baseOffset.height

    markers.append(
      GridLineAnnotation(
        text: "\(index)",
        point: CGPoint(x: valX, y: valY)
      )
    )
  }

//  private func shouldDrawMarker(for index: Int) -> Bool {
//    guard annotationDensity.isShowingCellMarkers else { return false }
//    guard let stepSize = annotationDensity.stepSize, stepSize > 0 else { return false }
//    return index.isMultiple(of: stepSize)
//  }
}
