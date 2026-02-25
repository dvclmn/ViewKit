//
//  GridLines+Draw.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import BasePrimitives
import SwiftUI

extension GraphicsContext {

  public func drawGridLines(
    config: GridConfiguration,
    containerSize: CGSize,
  ) {

    guard let cellSize = self.environment.unitSize else { return }
    let zoom = self.environment.zoomLevel
    let cell = cellSize * zoom
    let gridSize = config.gridSize(from: cellSize)

    let columns = gridSize?.width.gridLength ?? 1
    let rows = gridSize?.height.gridLength ?? 1

    let path = Path.grid(
      containerSize: containerSize,
      cellSize: cell,
      mode: .bounded(columns: columns, rows: rows)
    )

    self.stroke(path, with: .color(config.colour), lineWidth: config.lineWidth)

    //    let zoomLevel = self.environment.zoomLevel
    //    let zoomedCell = config.cellSize * zoomLevel
    //
    //    let (columns, rows) = (
    //      config.gridSize?.width.gridLength ?? 1,
    //      config.gridSize?.height.gridLength ?? 1,
    //    )
    //    let path = Path.createGrid(
    //      columns: columns,
    //      rows: rows,
    //      cellSize: zoomedCell,
    //      containerSize: containerSize
    //    )
    //    self.stroke(
    //      path,
    //      with: .color(config.colour),
    //      lineWidth: config.lineWidth
    //    )
  }
}

extension GraphicsContext {

  /// Note: was previously `in rect: CGRect`, but the `origin`
  /// wasn't being used, so changed to `size`.
  public func drawInfiniteGrid(
    in containerSize: CGSize,
    config: GridConfiguration
  ) {

    guard let cellSize = self.environment.unitSize else { return }
    guard config.shouldDrawLines else { return }

    let pan = self.environment.panOffset
    let cell = cellSize

    let path = Path.grid(
      containerSize: containerSize,
      cellSize: cell,
      mode: .infinite(offset: pan),
      onVerticalIndex: { i, x in
        if i % config.density.rawValue == 0 {
          self.draw(
            Text("\(i)").font(.caption2).foregroundColor(.secondary),
            at: CGPoint(x: x + 4, y: 20))
        }
      }
    )

    self.stroke(path, with: .color(config.colour), lineWidth: config.lineWidth)

    //    guard config.shouldDrawLines else { return }
    //
    //    let pan = self.environment.panOffset
    //    let cellSize = config.cellSize
    //
    //    var path = Path()
    //
    //    /// Vertical Lines (Columns)
    //    /// Find the first line index that would be visible on the left
    //    let startCol = Int(floor(-pan.width / containerSize.width))
    ////    let startCol = Int(floor(-pan.x / size.width))
    //    let endCol = startCol + Int(ceil(containerSize.width / cellSize.width)) + 1
    //
    //    for i in startCol...endCol {
    //      let x = CGFloat(i) * size.width + pan.width
    ////      let x = CGFloat(i) * size.width + pan.x
    //      path.move(to: CGPoint(x: x, y: 0))
    //      path.addLine(to: CGPoint(x: x, y: size.height))
    //
    //      /// Annotation Logic
    //      if i % config.density.rawValue == 0 {
    //        drawAnnotation("\(i)", at: CGPoint(x: x + 4, y: 20))
    //      }
    //    }
    //
    //    /// Horizontal Lines (Rows)
    //    let startRow = Int(floor(-pan.height / size.height))
    ////    let startRow = Int(floor(-pan.y / size.height))
    //    let endRow = startRow + Int(ceil(size.height / size.height)) + 1
    //
    //    for i in startRow...endRow {
    //      let y = CGFloat(i) * size.height + pan.height
    ////      let y = CGFloat(i) * size.height + pan.y
    //      path.move(to: CGPoint(x: 0, y: y))
    //      path.addLine(to: CGPoint(x: size.width, y: y))
    //    }
    //
    //    /// Single stroke call is much more efficient than filling individual rects
    //    self.stroke(path, with: .color(config.colour), lineWidth: config.lineWidth)
  }

  private func drawAnnotation(_ text: String, at point: CGPoint) {
    self.draw(Text(text).font(.caption2).foregroundColor(.secondary), at: point)
  }
}
