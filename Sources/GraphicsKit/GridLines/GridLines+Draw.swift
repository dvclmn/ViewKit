//
//  GridLines+Draw.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import BasePrimitives
import SwiftUI

extension GraphicsContext {

  /// Note: Annotation vis. and density now determined by
  /// Env value and `FontCompression`
  public func drawGrid(
    unitSizeOverride: CGSize? = nil,
    in containerSize: CGSize,
    sizeMode: GridSizeMode = .fillContainer,
    pinMode: GridPinMode = .canvas,
    lineColour: Color = .gray.opacity(0.2),
    lineWidth: CGFloat = 1,
//    annotations: GridAnnotationDensity = .none,
    drawsBorder: Bool = true
  ) {
    guard
      let context = GridLineContext(
        unitSizeOverride: unitSizeOverride,
        containerSize: containerSize,
        sizeMode: sizeMode,
        pinMode: pinMode,
        lineWidth: lineWidth,
//        annotationDensity: annotations,
        drawsBorder: drawsBorder,
        environment: self.environment
      ),
      let output = context.makeOutput()
    else { return }

    self.stroke(
      output.path,
      with: .color(lineColour),
      lineWidth: output.lineWidth
    )

    guard environment.isShowingCellNumbers else { return }
    output.annotations.forEach { annotation in
      drawAnnotation(
        annotation.text,
        at: annotation.point,
        cellSize: context.unitSize,
        zoom: environment.zoomLevel,
        zoomRange: environment.zoomRange?.toCGFloatRange
      )
    }
  }

  private func drawAnnotation(
    _ text: String,
    at point: CGPoint,
    cellSize: CGSize,
    zoom: CGFloat,
    zoomRange: ClosedRange<CGFloat>?
  ) {
    let baseFontSize: CGFloat = 12

    /// Build a compression helper that takes into account zoom, range,
    /// sensitivity, and cell size.
    ///
    /// `text.count` is clamped internally, no need to sanitise at this level.
    let compressor = FontCompression(
      fontSize: baseFontSize,
      cellSize: cellSize,
      zoom: zoom,
      zoomRange: zoomRange,
      sensitivity: 0.2,
      characterCount: text.count
    )

    let result = compressor.makeFont()

    /// Skip drawing if we determine there's not enough room for a legible mark
    guard result.visible else { return }

    let styled = Text(text)
      .font(.system(size: result.size))
      .fontWidth(result.width)
      .foregroundColor(.secondary.opacity(0.7))

    self.draw(styled, at: point)
  }
}
