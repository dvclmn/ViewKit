//
//  Path+Grid.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/2/2026.
//

import CoreTools
import SwiftUI

public typealias VerticalIndexOutput = (_ index: Int, _ x: CGFloat) -> Void

public enum GridLinesMode {
  /// Draw enough lines to cover the container, choosing indices based on offset
  case infinite(offset: CGSize)

  /// Draw a fixed number of columns/rows starting at zero (no negative indices)
  case bounded(columns: Int, rows: Int)
}

extension Path {
  public static func boundedGrid(
    dimensions: GridDimensions,
    cellSize: CGSize,
    containerSize: CGSize,
    drawsBorder: Bool
  ) -> Path {
    let cols = max(0, dimensions.width)
    let rows = max(0, dimensions.height)

    let cw = cellSize.width
    let ch = cellSize.height

    guard containerSize.width > 0, containerSize.height > 0, cw > 0, ch > 0 else {
      return Path()
    }

    let rowStart = drawsBorder ? 0 : 1
    let rowEnd = drawsBorder ? rows : max(0, rows - 1)

    let colStart = drawsBorder ? 0 : 1
    let colEnd = drawsBorder ? cols : max(0, cols - 1)

    /// If the grid is too small to have “inner” lines, return empty.
    guard rowStart <= rowEnd || colStart <= colEnd else { return Path() }

    return Path { p in
      /// Horizontal
      if rowStart <= rowEnd {
        for r in rowStart...rowEnd {
          let y = CGFloat(r) * ch
          p.move(to: CGPoint(x: 0, y: y))
          p.addLine(to: CGPoint(x: containerSize.width, y: y))
        }
      }
      /// Vertical
      if colStart <= colEnd {
        for c in colStart...colEnd {
          let x = CGFloat(c) * cw
          p.move(to: CGPoint(x: x, y: 0))
          p.addLine(to: CGPoint(x: x, y: containerSize.height))
        }
      }
    }

  }

  /// For eplison; to align with border stroke width, follow rule of thumb:
  /// ```
  /// edgeEpsilon: max(0.5, config.lineWidth / 2)
  ///
  /// ```
  ///
  /// Note: `cellSize` must be original unit/unzoomed size.
  /// Passing "cell size plus zoom" will produce undefined results
  ///
  /// Epsilon here means a small tolerance band (in points) used to decide whether a candidate
  /// grid line should be considered “on” the container’s edge (left/right or top/bottom).
  ///
  /// It accounts for floating‑point rounding and stroke width so an “inner” grid line
  /// isn't drawn right on top of the border line, or miss it due to tiny numeric drift.
  public static func infiniteGrid(
    containerSize: CGSize,
    cellSize: CGSize,
    offset: CGSize,
    drawsBorder: Bool,
    edgeEpsilon: CGFloat = 0.5,
    onVerticalIndex: VerticalIndexOutput? = nil
  ) -> Path {
    let w = containerSize.width
    let h = containerSize.height
    let cw = cellSize.width
    let ch = cellSize.height

    guard w > 0, h > 0, cw > 0, ch > 0 else { return Path() }

    let startCol = Int(floor((-offset.width) / cw))
    let endCol = Int(ceil((w - offset.width) / cw))

    let startRow = Int(floor((-offset.height) / ch))
    let endRow = Int(ceil((h - offset.height) / ch))

    func isOnVerticalEdge(_ x: CGFloat) -> Bool {
      abs(x - 0) <= edgeEpsilon || abs(x - w) <= edgeEpsilon
    }
    func isOnHorizontalEdge(_ y: CGFloat) -> Bool {
      abs(y - 0) <= edgeEpsilon || abs(y - h) <= edgeEpsilon
    }

    return Path { p in
      for i in startCol...endCol {
        let x = CGFloat(i) * cw + offset.width
        if !drawsBorder, isOnVerticalEdge(x) { continue }

        p.move(to: CGPoint(x: x, y: 0))
        p.addLine(to: CGPoint(x: x, y: h))
        onVerticalIndex?(i, x)
      }

      for i in startRow...endRow {
        let y = CGFloat(i) * ch + offset.height
        if !drawsBorder, isOnHorizontalEdge(y) { continue }

        p.move(to: CGPoint(x: 0, y: y))
        p.addLine(to: CGPoint(x: w, y: y))
      }
    }
  }
}
