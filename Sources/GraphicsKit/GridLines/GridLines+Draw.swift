//
//  GridLines+Draw.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import CoreTools
import SwiftUI

extension GraphicsContext {

  /// Note: Annotation vis. and density now determined by
  /// Env value and `FontCompression`
  ///
  /// To customise line colour and width, set env values
  /// `gridLineColour` and `gridLineWidth`
  public mutating func drawGrid(
    domain: GridFontDomain,
    in containerSize: CGSize,
    sizeMode: GridSizeMode = .fillContainer,
    pinMode: GridPinMode = .canvas,
    drawsBorder: Bool = true
  ) {
    
    // MARK: - Grid Lines
    /// Prepare context and create output
    guard
      let context = GridLineContext(
        domain: domain,
        containerSize: containerSize,
        sizeMode: sizeMode,
        pinMode: pinMode,
        drawsBorder: drawsBorder,
        environment: self.environment
      ),
      let output = context.makeOutput()
    else { return }

    /// Stroke the Grid lines
    self.stroke(
      output.path,
      with: .color(environment.gridLineColour),
      lineWidth: output.lineWidth
    )

    // MARK: - Cell Numbers
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
      .foregroundColor(.secondary.opacity(0.7 * result.opacity))

    self.draw(styled, at: point)
  }
}
