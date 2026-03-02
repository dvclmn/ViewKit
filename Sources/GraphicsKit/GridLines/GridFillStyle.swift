//
//  GridSizeMode.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/2/2026.
//

import CoreTools
import SwiftUI


/// `fill(size: CGSize)` is ambiguous about which size, or what size means
///
/// Should probably clarify, or be specific at call sites;
/// - Passing a `containerSize`, means “grid that fills the viewport”.
/// - Passing a `contentSize`, means “grid that matches the content extent”.
public enum GridSizeMode {
  case fixed(columns: Int, rows: Int)
  case fill(size: CGSize)

  /// To be used in a context where a Canvas view `size` can be passed in
  case fillContainer
}

extension GridSizeMode {

  /// I'm pretty sure `cellSize` should be the zoomed size
  public func path(
    for cellSize: CGSize,
    in containerSize: CGSize,
    panOffset: CGSize,
    pinMode: GridPinMode,
    drawsBorder: Bool,
  ) -> Path? {

    guard
      let dimensions = gridDimensions(
        from: cellSize,
        in: containerSize
      )
    else { return nil }
    let path: Path

    switch self {
      case .fixed, .fill:
        path = .boundedGrid(
          dimensions: dimensions,
          cellSize: cellSize,
          containerSize: containerSize,
          drawsBorder: drawsBorder
        )

      case .fillContainer:
        //        let panEnv = self.environment.panOffset
        let effectivePanOffset = pinMode == .viewport ? -panOffset : .zero

        path = .infiniteGrid(
          containerSize: containerSize,
          cellSize: cellSize,
          offset: effectivePanOffset,
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
  }

  /// Should cellSize be before or after zoom? I'm not sure
  private func gridDimensions(
    from cellSize: CGSize,
    in containerSize: CGSize
  ) -> GridDimensions? {
    switch self {
      case .fixed(let columns, let rows):
        guard columns > 0, rows > 0 else { return nil }
        return GridDimensions(width: columns, height: rows)

      case .fill(let size):
        return size.toGridDimensions(using: cellSize)

      case .fillContainer:
        return containerSize.toGridDimensions(using: cellSize)
    }
  }
}
