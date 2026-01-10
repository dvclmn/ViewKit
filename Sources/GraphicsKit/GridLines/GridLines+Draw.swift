//
//  GridLines+Draw.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import SwiftUI
import BasePrimitives

extension GraphicsContext {

  public func drawGridLines(
    config: GridConfiguration,
    containerSize: CGSize,
    canvasZoom: CGFloat
  ) {
    let zoomed = config.cellSize * canvasZoom
    let (columns, rows) = (
      config.gridSize?.width.gridLength ?? 1,
      config.gridSize?.height.gridLength ?? 1,
    )
    let path = Path.createGrid(
      columns: columns,
      rows: rows,
      cellSize: zoomed,
      containerSize: containerSize
    )
    self.stroke(
      path,
      with: .color(config.colour),
      lineWidth: config.lineWidth
    )
  }
}

extension GraphicsContext {
  public func drawInfiniteGrid(
    in rect: CGRect,  // The viewport/container size
    config: GridConfiguration
  ) {
    guard config.shouldDrawLines else { return }

    let pan = config.pan
    let size = config.cellSize

    var path = Path()

    /// Vertical Lines (Columns)
    /// Find the first line index that would be visible on the left
    let startCol = Int(floor(-pan.width / size.width))
//    let startCol = Int(floor(-pan.x / size.width))
    let endCol = startCol + Int(ceil(rect.width / size.width)) + 1

    for i in startCol...endCol {
      let x = CGFloat(i) * size.width + pan.width
//      let x = CGFloat(i) * size.width + pan.x
      path.move(to: CGPoint(x: x, y: 0))
      path.addLine(to: CGPoint(x: x, y: rect.height))

      /// Annotation Logic
      if i % config.density.rawValue == 0 {
        drawAnnotation("\(i)", at: CGPoint(x: x + 4, y: 20))
      }
    }

    /// Horizontal Lines (Rows)
    let startRow = Int(floor(-pan.height / size.height))
//    let startRow = Int(floor(-pan.y / size.height))
    let endRow = startRow + Int(ceil(rect.height / size.height)) + 1

    for i in startRow...endRow {
      let y = CGFloat(i) * size.height + pan.height
//      let y = CGFloat(i) * size.height + pan.y
      path.move(to: CGPoint(x: 0, y: y))
      path.addLine(to: CGPoint(x: rect.width, y: y))
    }

    /// Single stroke call is much more efficient than filling individual rects
    self.stroke(path, with: .color(config.colour), lineWidth: config.lineWidth)
  }

  private func drawAnnotation(_ text: String, at point: CGPoint) {
    self.draw(Text(text).font(.caption2).foregroundColor(.secondary), at: point)
  }
}
