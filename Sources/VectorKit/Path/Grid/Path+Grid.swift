//
//  Path+Grid.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/2/2026.
//

import CoreTools
import SwiftUI

public enum GridLinesMode {
  /// Draw enough lines to cover the container, choosing indices based on offset
  case infinite(offset: CGSize)

  /// Draw a fixed number of columns/rows starting at zero (no negative indices)
  case bounded(columns: Int, rows: Int)
}

extension Path {
  public static func boundedGrid(
    unitSize: UnitSize,
    containerSize: CGSize,
    drawsBorder: Bool
  ) -> Path {
    let cols = max(0, unitSize.width.magnitude)
    let rows = max(0, unitSize.height.magnitude)

    let cw = unitSize.width.unitLength
    let ch = unitSize.height.unitLength

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
  public static func infiniteGrid(
    containerSize: CGSize,
    unitCell: CGSize,
    offset: CGSize,
    drawsBorder: Bool,
    edgeEpsilon: CGFloat = 0.5,
    onVerticalIndex: ((Int, CGFloat) -> Void)? = nil
  ) -> Path {
    let w = containerSize.width
    let h = containerSize.height
    let cw = unitCell.width
    let ch = unitCell.height

    guard w > 0, h > 0, cw > 0, ch > 0 else { return Path() }

    //    let startCol = Int(floor((-offset.width) / cw))
    //    let endCol = Int(ceil((w - offset.width) / cw))
    //
    //    let startRow = Int(floor((-offset.height) / ch))
    //    let endRow = Int(ceil((h - offset.height) / ch))

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
    //    return Path { p in
    //      for i in startCol...endCol {
    //        let x = CGFloat(i) * cw + offset.width
    //        p.move(to: CGPoint(x: x, y: 0))
    //        p.addLine(to: CGPoint(x: x, y: h))
    //        onVerticalIndex?(i, x)
    //      }
    //
    //      for i in startRow...endRow {
    //        let y = CGFloat(i) * ch + offset.height
    //        p.move(to: CGPoint(x: 0, y: y))
    //        p.addLine(to: CGPoint(x: w, y: y))
    //      }
    //    }
  }
}

//  public static func grid(
//    containerSize: CGSize,
//    cellSize: CGSize,
//    mode: GridLinesMode,
//    onVerticalIndex: ((Int, CGFloat) -> Void)? = nil
//  ) -> Path {
//    let w = containerSize.width
//    let h = containerSize.height
//    let cw = cellSize.width
//    let ch = cellSize.height
//
//    guard w > 0, h > 0, cw > 0, ch > 0 else { return Path() }
//
//    func verticalRange(offsetX: CGFloat) -> ClosedRange<Int> {
//      // leftmost visible index … rightmost visible index (+1 as buffer)
//      let start = Int(floor((-offsetX) / cw))
//      let end = Int(ceil((w - offsetX) / cw))
//      return start...end
//    }
//
//    func horizontalRange(offsetY: CGFloat) -> ClosedRange<Int> {
//      let start = Int(floor((-offsetY) / ch))
//      let end = Int(ceil((h - offsetY) / ch))
//      return start...end
//    }
//
//    let offset: CGSize
//    let colRange: ClosedRange<Int>
//    let rowRange: ClosedRange<Int>
//
//    switch mode {
//      case .infinite(let o):
//        offset = o
//        colRange = verticalRange(offsetX: o.width)
//        rowRange = horizontalRange(offsetY: o.height)
//
//      case .bounded(let columns, let rows):
//        offset = .zero
//        colRange = 0...max(0, columns)
//        rowRange = 0...max(0, rows)
//    }
//
//    return Path { p in
//      // Vertical
//      for i in colRange {
//        let x = CGFloat(i) * cw + offset.width
//        p.move(to: CGPoint(x: x, y: 0))
//        p.addLine(to: CGPoint(x: x, y: h))
//        onVerticalIndex?(i, x)
//      }
//
//      // Horizontal
//      for i in rowRange {
//        let y = CGFloat(i) * ch + offset.height
//        p.move(to: CGPoint(x: 0, y: y))
//        p.addLine(to: CGPoint(x: w, y: y))
//      }
//    }
//  }
//}
