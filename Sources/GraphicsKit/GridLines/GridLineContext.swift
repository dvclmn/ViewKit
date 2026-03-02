//
//  GridLineContext.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 2/3/2026.
//

import CoreTools
import SwiftUI

struct GridLineContext {
  let unitSize: CGSize
  let containerSize: CGSize
  let sizeMode: GridSizeMode
  let pinMode: GridPinMode
  let lineColour: Color
  let lineWidth: CGFloat
  let annotations: GridAnnotationDensity
  let drawsBorder: Bool
  let panOffset: CGSize
  let zoomLevel: CGFloat
  let zoomRange: ClosedRange<CGFloat>?
}

struct GridLineAnnotation {
  let text: String
  let point: CGPoint
}

struct GridLineOutput {
  let path: Path
  let lineColour: Color
  let lineWidth: CGFloat
  let annotations: [GridLineAnnotation]
}

extension GridLineContext {
  init?(
    unitSizeOverride: CGSize?,
    containerSize: CGSize,
    sizeMode: GridSizeMode,
    pinMode: GridPinMode,
    lineColour: Color,
    lineWidth: CGFloat,
    annotations: GridAnnotationDensity,
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
    self.lineColour = lineColour
    self.lineWidth = lineWidth
    self.annotations = annotations
    self.drawsBorder = drawsBorder
    self.panOffset = environment.panOffset
    self.zoomLevel = CGFloat(environment.zoomLevel)
    self.zoomRange = environment.zoomRange?.toCGFloatRange
  }

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
          lineColour: lineColour,
          lineWidth: effectiveLineWidth,
          annotations: []
        )

      case .fillContainer:
        var markers: [GridLineAnnotation] = []
        let path = Path.infiniteGrid(
          containerSize: containerSize,
          cellSize: zoomedUnitSize,
          offset: effectivePanOffset,
          drawsBorder: drawsBorder,
          edgeEpsilon: edgeEpsilon,
          onVerticalIndex: { index, x in
            guard shouldDrawMarker(for: index) else { return }
            markers.append(
              GridLineAnnotation(
                text: "\(index)",
                point: CGPoint(x: x + 4, y: 20)
              )
            )
          }
        )

        return GridLineOutput(
          path: path,
          lineColour: lineColour,
          lineWidth: effectiveLineWidth,
          annotations: markers
        )
    }
  }

  private func shouldDrawMarker(for index: Int) -> Bool {
    guard annotations.isShowingCellMarkers else { return false }
    guard let stepSize = annotations.stepSize, stepSize > 0 else { return false }
    return index.isMultiple(of: stepSize)
  }
}
