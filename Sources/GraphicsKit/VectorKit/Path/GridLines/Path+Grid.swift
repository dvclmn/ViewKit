//
//  Path+Grid.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/2/2026.
//

import BaseTools
import GridPrimitives
import SwiftUI

extension Path {

  public static func infiniteGrid(
    originOffset: GridPosition,
    containerSize: CGSize,
    cellSize: CGSize,
    offset: CGSize,
    drawsBorder: Bool,
    edgeEpsilon: CGFloat = 0.5,
    onHorizontalIndex: ((GridLine) -> Void)? = nil,
    onVerticalIndex: ((GridLine) -> Void)? = nil,
  ) -> Path {
    var path = Path()
    let w = containerSize.width
    let h = containerSize.height
    let cw = cellSize.width
    let ch = cellSize.height

    guard w > 0, h > 0, cw > 0, ch > 0 else { return path }

    let originX = originOffset.x.toScreenLength(along: .horizontal, using: cellSize)
    let originY = originOffset.y.toScreenLength(along: .vertical, using: cellSize)
    let origin = CGPoint(x: originX, y: originY)

    let startCol = Int(floor((-offset.width) / cw))
    let endCol = Int(ceil((w - offset.width) / cw))

    let startRow = Int(floor((-offset.height) / ch))
    let endRow = Int(ceil((h - offset.height) / ch))

    /// Columns (Varying along X)
    path.addGridAxis(
      .horizontal,
      range: startCol...endCol,
      cellSize: cw,
      panningOffset: offset.width,
      gridOrigin: origin,
      crossLength: h,
      containerLimit: w,
      drawsBorder: drawsBorder,
      edgeEpsilon: edgeEpsilon,
      onIndex: onHorizontalIndex,
    )

    /// Rows (Varying along Y)
    path.addGridAxis(
      .vertical,
      range: startRow...endRow,
      cellSize: ch,
      panningOffset: offset.height,
      gridOrigin: origin,
      crossLength: w,
      containerLimit: h,
      drawsBorder: drawsBorder,
      edgeEpsilon: edgeEpsilon,
      onIndex: onVerticalIndex,
    )

    return path
  }

  public static func boundedGrid(
    rect: GridRect,
    cellSize: CGSize,
    containerSize: CGSize,
    drawsBorder: Bool,
  ) -> Path {
    var path = Path()
    let cols = max(0, rect.size.width)
    let rows = max(0, rect.size.height)

    guard containerSize.width > 0, containerSize.height > 0,
      cellSize.width > 0, cellSize.height > 0
    else {
      return path
    }

    let origin = CGPoint(x: CGFloat(rect.origin.x), y: CGFloat(rect.origin.y))

    let colStart = drawsBorder ? 0 : 1
    let colEnd = drawsBorder ? cols : max(0, cols - 1)
    let rowStart = drawsBorder ? 0 : 1
    let rowEnd = drawsBorder ? rows : max(0, rows - 1)

    path.addGridAxis(
      .horizontal,
      range: colStart...colEnd,
      cellSize: cellSize.width,
      panningOffset: 0,  // Bounded grids don't pan
      gridOrigin: origin,
      crossLength: containerSize.height,
      containerLimit: containerSize.width,
      drawsBorder: true,  // border handled in range above, bypass internal edge skip
      onIndex: nil,
    )

    path.addGridAxis(
      .vertical,
      range: rowStart...rowEnd,
      cellSize: cellSize.height,
      panningOffset: 0,
      gridOrigin: origin,
      crossLength: containerSize.width,
      containerLimit: containerSize.height,
      drawsBorder: true,
      onIndex: nil,
    )

    return path
  }
}

//extension Path {
//  public static func boundedGrid(
//    rect: GridRect,
//    cellSize: CGSize,
//    containerSize: CGSize,
//    drawsBorder: Bool,
//  ) -> Path {
//    /// rect.origin encodes any top/leading offset caused by header row/column (row/col numbers)
//    /// rect.size encodes the number of grid cells to render in each direction
//    let originX: Int = rect.origin.x
//    let originY: Int = rect.origin.y
//
//    let cols: Int = max(0, rect.size.width)
//    let rows: Int = max(0, rect.size.height)
//
//    let cw: CGFloat = cellSize.width
//    let ch: CGFloat = cellSize.height
//
//    guard containerSize.width > 0, containerSize.height > 0, cw > 0, ch > 0 else {
//      return Path()
//    }
//
//    let rowStart = drawsBorder ? 0 : 1
//    let rowEnd = drawsBorder ? rows : max(0, rows - 1)
//
//    let colStart = drawsBorder ? 0 : 1
//    let colEnd = drawsBorder ? cols : max(0, cols - 1)
//
//    /// If the grid is too small to have “inner” lines, return empty.
//    guard rowStart <= rowEnd, colStart <= colEnd else { return Path() }
//
//    return Path { p in
//      /// Horizontal lines (rows)
//      for r in rowStart...rowEnd {
//        let x = CGFloat(originX)
//        let y = CGFloat(originY) + CGFloat(r) * ch
//        p.move(to: CGPoint(x: x, y: y))
//        p.addLine(to: CGPoint(x: x + containerSize.width, y: y))
//      }
//
//      /// Vertical lines (columns)
//      for c in colStart...colEnd {
//        let x = CGFloat(originX) + CGFloat(c) * cw
//        let y = CGFloat(originY)
//        p.move(to: CGPoint(x: x, y: y))
//        p.addLine(to: CGPoint(x: x, y: y + containerSize.height))
//      }
//    }
//  }
//
//  /// For eplison; to align with border stroke width, follow rule of thumb:
//  /// ```
//  /// edgeEpsilon: max(0.5, config.lineWidth / 2)
//  ///
//  /// ```
//  ///
//  /// Note: `cellSize` must be original unit/unzoomed size.
//  /// Passing "cell size plus zoom" will produce undefined results
//  ///
//  /// Epsilon here means a small tolerance band (in points) used to decide whether a candidate
//  /// grid line should be considered “on” the container’s edge (left/right or top/bottom).
//  ///
//  /// It accounts for floating‑point rounding and stroke width so an “inner” grid line
//  /// isn't drawn right on top of the border line, or miss it due to tiny numeric drift.
//  public static func infiniteGrid(
//    originOffset: GridPosition,
//    containerSize: CGSize,
//    cellSize: CGSize,
//    offset: CGSize,
//    drawsBorder: Bool,
//    edgeEpsilon: CGFloat = 0.5,
//    onHorizontalIndex: ((GridLine) -> Void)? = nil,
//    onVerticalIndex: ((GridLine) -> Void)? = nil,
//  ) -> Path {
//    let w = containerSize.width
//    let h = containerSize.height
//    let cw = cellSize.width
//    let ch = cellSize.height
//
//    /// Origin offset: if the caller wants to shift the grid (e.g. to leave room for headers),
//    /// incorporate it here. For now we assume (0,0); callers can bake header space into `offset`.
//
//    let originX = originOffset.x.toScreenLength(
//      along: .horizontal,
//      using: cellSize,
//    )
//    let originY = originOffset.y.toScreenLength(
//      along: .vertical,
//      using: cellSize,
//    )
//
//    guard w > 0, h > 0, cw > 0, ch > 0 else { return Path() }
//
//    let startCol = Int(floor((-offset.width) / cw))
//    let endCol = Int(ceil((w - offset.width) / cw))
//
//    let startRow = Int(floor((-offset.height) / ch))
//    let endRow = Int(ceil((h - offset.height) / ch))
//
//    /// Note: these edge checks are relative to the container bounds (0 to w/h), NOT the origin offset.
//    func isOnVerticalEdge(_ x: CGFloat) -> Bool {
//      abs(x - 0) <= edgeEpsilon || abs(x - w) <= edgeEpsilon
//    }
//    func isOnHorizontalEdge(_ y: CGFloat) -> Bool {
//      abs(y - 0) <= edgeEpsilon || abs(y - h) <= edgeEpsilon
//    }
//
//    return Path { p in
//      /// Columns -> vertical lines at fixed x
//      for i in startCol...endCol {
//        let x = CGFloat(i) * cw + offset.width
//        guard x >= -edgeEpsilon, x <= w + edgeEpsilon else { continue }
//        if !drawsBorder, isOnVerticalEdge(x) { continue }
//
//        p.move(to: CGPoint(x: x + originX, y: originY))
//        p.addLine(to: CGPoint(x: x + originX, y: originY + h))
//
//        let line = GridLine(
//          axis: .horizontal,
//          index: i,
//          position: x,
//        )
//        onHorizontalIndex?(line)
//      }
//
//      /// Rows -> horizontal lines at fixed y
//      for i in startRow...endRow {
//        let y = CGFloat(i) * ch + offset.height
//        guard y >= -edgeEpsilon, y <= h + edgeEpsilon else { continue }
//        if !drawsBorder, isOnHorizontalEdge(y) { continue }
//
//        p.move(to: CGPoint(x: originX, y: y + originY))
//        p.addLine(to: CGPoint(x: originX + w, y: y + originY))
//
//        let line = GridLine(
//          axis: .vertical,
//          index: i,
//          position: y,
//        )
//        onHorizontalIndex?(line)
//      }
//    }
//  }
//}
