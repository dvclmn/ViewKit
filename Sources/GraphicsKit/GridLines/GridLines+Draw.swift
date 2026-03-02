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
      drawAnnotation(annotation.text, at: annotation.point)
    }
  }

  private func drawAnnotation(_ text: String, at point: CGPoint) {
    let text = Text(text).font(.caption2).foregroundColor(.secondary)
    self.draw(text, at: point)
  }
}
