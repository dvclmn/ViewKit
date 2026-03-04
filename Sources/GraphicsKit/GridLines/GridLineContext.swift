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
  let lineWidth: CGFloat
  let annotations: [GridLineAnnotation]
}

// MARK: - Main Context
struct GridLineContext {
  let unitSize: CGSize
  //  let gridDimensions: GridDimensions
  let gridRect: GridRect
  let containerSize: CGSize
  let sizeMode: GridSizeMode
  let pinMode: GridPinMode
  let lineWidth: CGFloat
  let drawsBorder: Bool
  let panOffset: CGSize
  let zoomLevel: CGFloat
  let zoomRange: ClosedRange<CGFloat>?
  let hasCellNumbers: Bool
}

extension GridLineContext {
  init?(
    domain: GridFontDomain,
    containerSize: CGSize,
    sizeMode: GridSizeMode,
    pinMode: GridPinMode,
    drawsBorder: Bool,
    environment: EnvironmentValues
  ) {
    guard let unitSize = environment[keyPath: domain.unitSizeKey] else {
      return nil
    }
    guard let dimensions = environment.gridDimensions else { return nil }

    self.unitSize = unitSize
    self.containerSize = containerSize
    self.sizeMode = sizeMode
    self.pinMode = pinMode
    self.lineWidth = environment.gridLineWidth
    self.drawsBorder = drawsBorder
    self.panOffset = environment.panOffset
    self.zoomLevel = environment.zoomLevel.toCGFloat
    self.zoomRange = environment.zoomRange?.toCGFloatRange
    self.hasCellNumbers = environment.isShowingCellNumbers
    self.gridRect = GridRect(origin: .zero, size: dimensions)
  }
}

extension GridLineContext {

  func makeOutput() -> GridLineOutput? {
    return switch sizeMode {
      case .fixed, .fill: boundedGrid()
      case .fillContainer: infiniteGrid()
    }
  }

}

extension GridLineContext {
  var zoomedUnitSize: CGSize { unitSize * zoomLevel }

  var cellNumberOffsetFactor: Int {
    hasCellNumbers ? 1 : 0
  }

  var effectiveLineWidth: CGFloat {
    lineWidth.removingZoom(
      zoomLevel,
      across: zoomRange,
      sensitivity: 0.2
    )
  }

  var edgeEpsilon: CGFloat {
    max(0.5, effectiveLineWidth / 2)
  }

  var effectivePanOffset: CGSize {
    pinMode == .viewport ? -panOffset : .zero
  }

}

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

    //    print("Rect is \(gridRect)")

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
    for axis: GridAxis,
    at index: Int,
    position: CGFloat,
    markers: inout [GridLineAnnotation]
  ) {

    let offsetLength = unitSize.shortestDimension

    /// This adds a little extra height, so both lines of numbers feel balanced
    let offset = CGSize(width: offsetLength, height: offsetLength * 1.2)

    /// Minus `unitSize` at the end offsets the numbers to the
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
