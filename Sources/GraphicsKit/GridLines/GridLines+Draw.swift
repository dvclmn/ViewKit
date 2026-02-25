//
//  GridLines+Draw.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import BasePrimitives
import SwiftUI

public enum GridPinMode {
  /// Pin lines to Viewport
  /// Grid lines will remain fixed in 'screen space'
  /// Panning will not affect/move grid lines.
  case viewport

  /// Pin lines to Pan offset
  /// Grid lines will be anchored to the pannable 'canvas'
  /// view, so panning will move the Grid Lines.
  case panOffset
}

extension GraphicsContext {

  public func drawGrid(
    in containerSize: CGSize,
    sizeMode: GridSizeMode = .fillContainer,
    pinMode: GridPinMode = .panOffset,
    lineColour: Color = .gray.opacity(0.2),
    lineWidth: CGFloat = 1,
    annotations: GridAnnotationDensity = .none,
    drawsBorder: Bool = true
  ) {

    guard let cellSize = self.environment.unitSize else { return }

    let zoom = self.environment.zoomLevel
    let cellZoomed = cellSize * zoom

    guard
      let gridSize = sizeMode.gridSize(
        from: cellZoomed,  // Or `cellSize`?
        in: containerSize
      )
    else { return }

    let path: Path

    switch sizeMode {
      case .fixed, .fill:
        path = .boundedGrid(
          unitSize: gridSize,
          containerSize: containerSize,
          drawsBorder: drawsBorder
        )

      case .fillContainer:
        let pan = self.environment.panOffset
        path = .infiniteGrid(
          containerSize: containerSize,
          unitCell: cellZoomed,
          offset: pan,
          drawsBorder: drawsBorder,
          edgeEpsilon: max(0.5, lineWidth / 2),
          onVerticalIndex: { i, x in
            if annotations.isShowingCellMarkers {
              self.draw(
                Text("\(i)").font(.caption2).foregroundColor(.secondary),
                at: CGPoint(x: x + 4, y: 20))
            }
          }
        )
    }

    self.stroke(path, with: .color(lineColour), lineWidth: lineWidth)
  }

  //  public func drawGridLines(
  //    config: GridConfiguration,
  //    containerSize: CGSize,
  //  ) {
  //
  //    guard let cellSize = self.environment.unitSize else { return }
  //    let zoom = self.environment.zoomLevel
  //    let cell = cellSize * zoom
  //    let gridSize = config.gridSize(from: cellSize)
  //
  //    let columns = gridSize?.width.gridLength ?? 1
  //    let rows = gridSize?.height.gridLength ?? 1
  //
  //    let path = Path.grid(
  //      containerSize: containerSize,
  //      cellSize: cell,
  //      mode: .bounded(columns: columns, rows: rows)
  //    )
  //
  //    self.stroke(path, with: .color(config.colour), lineWidth: config.lineWidth)
  //
  //    //    let zoomLevel = self.environment.zoomLevel
  //    //    let zoomedCell = config.cellSize * zoomLevel
  //    //
  //    //    let (columns, rows) = (
  //    //      config.gridSize?.width.gridLength ?? 1,
  //    //      config.gridSize?.height.gridLength ?? 1,
  //    //    )
  //    //    let path = Path.createGrid(
  //    //      columns: columns,
  //    //      rows: rows,
  //    //      cellSize: zoomedCell,
  //    //      containerSize: containerSize
  //    //    )
  //    //    self.stroke(
  //    //      path,
  //    //      with: .color(config.colour),
  //    //      lineWidth: config.lineWidth
  //    //    )
  //  }

  private func drawAnnotation(_ text: String, at point: CGPoint) {
    self.draw(Text(text).font(.caption2).foregroundColor(.secondary), at: point)
  }
}

//extension GraphicsContext {

/// Note: was previously `in rect: CGRect`, but the `origin`
/// wasn't being used, so changed to `size`.
//  public func drawInfiniteGrid(
//    in containerSize: CGSize,
//    config: GridConfiguration
//  ) {
//
//    guard let cellSize = self.environment.unitSize else { return }
//    guard config.shouldDrawLines else { return }
//
//    let pan = self.environment.panOffset
//    let cell = cellSize
//
//    let path = Path.grid(
//      containerSize: containerSize,
//      cellSize: cell,
//      mode: .infinite(offset: pan),
//      onVerticalIndex: { i, x in
//        if i % config.density.rawValue == 0 {
//          self.draw(
//            Text("\(i)").font(.caption2).foregroundColor(.secondary),
//            at: CGPoint(x: x + 4, y: 20))
//        }
//      }
//    )
//
//    self.stroke(path, with: .color(config.colour), lineWidth: config.lineWidth)
//
//  }

//}
