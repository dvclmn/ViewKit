//
//  Path+Grid.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/2/2026.
//

import SwiftUI
import CoreTools

public enum GridLinesMode {
  /// Draw enough lines to cover the container, choosing indices based on offset
  case infinite(offset: CGSize)

  /// Draw a fixed number of columns/rows starting at zero (no negative indices)
  case bounded(columns: Int, rows: Int)
}

extension Path {
  public static func boundedGrid(
    unitSize: UnitSize,
    containerSize: CGSize
  ) -> Path {
    let cols = max(0, unitSize.width.magnitude)
    let rows = max(0, unitSize.height.magnitude)
    
    let cw = unitSize.width.unitLength
    let ch = unitSize.height.unitLength
    
    guard containerSize.width > 0, containerSize.height > 0, cw > 0, ch > 0 else {
      return Path()
    }
    
    return Path { p in
      /// Horizontal
      for r in 0...rows {
        let y = CGFloat(r) * ch
        p.move(to: CGPoint(x: 0, y: y))
        p.addLine(to: CGPoint(x: containerSize.width, y: y))
      }
      
      /// Vertical
      for c in 0...cols {
        let x = CGFloat(c) * cw
        p.move(to: CGPoint(x: x, y: 0))
        p.addLine(to: CGPoint(x: x, y: containerSize.height))
      }
    }
  }
  
  public static func infiniteGrid(
    containerSize: CGSize,
    unitCell: CGSize,
    offset: CGSize,
    onVerticalIndex: ((Int, CGFloat) -> Void)? = nil
  ) -> Path {
    let w = containerSize.width
    let h = containerSize.height
    let cw = unitCell.width
    let ch = unitCell.height
    
    guard w > 0, h > 0, cw > 0, ch > 0 else { return Path() }
    
    let startCol = Int(floor((-offset.width) / cw))
    let endCol = Int(ceil((w - offset.width) / cw))
    
    let startRow = Int(floor((-offset.height) / ch))
    let endRow = Int(ceil((h - offset.height) / ch))
    
    return Path { p in
      for i in startCol...endCol {
        let x = CGFloat(i) * cw + offset.width
        p.move(to: CGPoint(x: x, y: 0))
        p.addLine(to: CGPoint(x: x, y: h))
        onVerticalIndex?(i, x)
      }
      
      for i in startRow...endRow {
        let y = CGFloat(i) * ch + offset.height
        p.move(to: CGPoint(x: 0, y: y))
        p.addLine(to: CGPoint(x: w, y: y))
      }
    }
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
