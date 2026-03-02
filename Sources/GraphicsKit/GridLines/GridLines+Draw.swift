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
    guard
      let context = GridLineContext(
        unitSizeOverride: unitSizeOverride,
        containerSize: containerSize,
        sizeMode: sizeMode,
        pinMode: pinMode,
        lineColour: lineColour,
        lineWidth: lineWidth,
        annotations: annotations,
        drawsBorder: drawsBorder,
        environment: self.environment
      ),
      let output = context.makeOutput()
    else { return }

    self.stroke(
      output.path,
      with: .color(output.lineColour),
      lineWidth: output.lineWidth
    )

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

    /// Build a compression helper that takes into account zoom, range, sensitivity, and cell size
    let compressor = FontCompression(
      fontSize: baseFontSize,
      cellSize: cellSize,
      zoom: zoom,
      zoomRange: zoomRange,
      sensitivity: 0.2,
      characterCount: max(1, text.count)
    )

    let result = compressor.makeFont()

    /// Skip drawing if we determine there's not enough room for a legible mark
    guard result.visible else { return }

    let styled = Text(text)
      .font(.system(size: result.size))
      .fontWidth(result.width)
      .foregroundColor(.secondary)

    self.draw(styled, at: point)
  }
}

struct FontCompression {
  let fontSize: CGFloat
  let cellSize: CGSize
  let zoom: CGFloat
  let zoomRange: ClosedRange<CGFloat>?
  let sensitivity: CGFloat
  let characterCount: Int

  /// Compute a font width, size, and visibility decision based on the available cell width and zoom.
  /// The logic progressively compresses width, slightly scales size (respecting `sensitivity`),
  /// and finally hides if even compressed text cannot fit at a legible size.
  func makeFont() -> (width: Font.Width, size: CGFloat, visible: Bool) {
    /// Start from a zoom-compensated size so annotation size remains perceptually stable
    let compensatedSize = fontSize.removingZoom(
      zoom,
      clampedTo: zoomRange,
      sensitivity: sensitivity
    )

    /// Rough average width factor for digits/ASCII in a system font
    /// This is an approximation; width compression will help when we get tight.
    let avgGlyphWidthFactor: CGFloat = 0.6

    /// Required width for this label at the compensated size
    let requiredWidth = compensatedSize * avgGlyphWidthFactor * CGFloat(max(1, characterCount))

    /// How much horizontal room we have relative to what we'd like
    let fitRatio = cellSize.width / max(1, requiredWidth)

    /// Decide width first based on how tight we are
    let width: Font.Width
    switch fitRatio {
      case 1.0...:
        width = .standard
      case 0.85..<1.0:
        width = .condensed
      case 0.7..<0.85:
        width = .compressed
      default:
        /// Extremely tight — use compressed and rely on size adjustment below
        width = .compressed
    }

    /// Allow some size adjustment based on how tight we are, tempered by sensitivity.
    /// We cap shrinkage to 20% by default, further reduced by (1 - sensitivity).
    let rawScale = min(1.0, max(0.8, fitRatio))
    let adjustedScale = 1 - (1 - rawScale) * sensitivity
    let finalSize = compensatedSize * adjustedScale

    /// If we're still far from fitting, consider it not visible to avoid clutter/illegibility.
    /// Threshold chosen empirically; tweak to taste.
    let visible = fitRatio >= 0.5

    return (width, finalSize, visible)
  }
}
