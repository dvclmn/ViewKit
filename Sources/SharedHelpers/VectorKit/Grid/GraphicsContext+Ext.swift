//
//  GraphicsContext+Ext.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/10/2025.
//

import SwiftUI

extension GraphicsContext {
  
  public func drawGridLines(
    config: GridLineConfiguration,
    containerSize: CGSize,
    canvasZoom: CGFloat
  ) {
    let zoomed = config.cellSize * canvasZoom
    let (columns, rows) = (
      config.gridSize?.columns.count ?? 1,
      config.gridSize?.rows.count ?? 1,
    )
    let path = Path.createGrid(
      columns: columns,
      rows: rows,
      cellSize: zoomed,
      containerSize: containerSize
    )
    self.stroke(path, with: .color(config.colour), lineWidth: config.strokeThickness)
  }

}
