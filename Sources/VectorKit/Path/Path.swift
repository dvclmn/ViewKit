//
//  Path.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/7/2025.
//

import SwiftUI

extension Path {

  public var toCGPath: CGPath { self.cgPath }

  /// Adds a variant of standard `Path/move(to:)` taking a
  /// `UnitPoint` and `CGSize`, instead of a `CGPoint`
  public mutating func move(to unitPoint: UnitPoint, in size: CGSize) {
    let point = unitPoint.toCGPoint(in: size)
    self.move(to: point)
  }

  /// Adds a variant of standard `Path/addLine(to:)` taking a
  /// `UnitPoint` and `CGSize`, instead of a `CGPoint`
  public mutating func addLine(to unitPoint: UnitPoint, in size: CGSize) {
    let point = unitPoint.toCGPoint(in: size)
    self.addLine(to: point)
  }

  /// Initialises a Path with a rect at `size` dimensions, and origin of `zero`
  public init(fromSize size: CGSize) {
    self.init { path in
      path.addRect(CGRect(origin: .zero, size: size))
    }
  }

  public init(
    fromPoints points: [CGPoint],
    type: PathStyle = .line,
    shouldDropFirst: Bool = true
  ) {
    self = points.createPath(type: type, shouldDropFirst: shouldDropFirst)
  }
}

public enum GridLinesMode {
  /// Draw enough lines to cover the container, choosing indices based on offset
  case infinite(offset: CGSize)
  
  /// Draw a fixed number of columns/rows starting at zero (no negative indices)
  case bounded(columns: Int, rows: Int)
}

extension Path {

  public static func grid(
    containerSize: CGSize,
    cellSize: CGSize,
    mode: GridLinesMode,
    onVerticalIndex: ((Int, CGFloat) -> Void)? = nil
  ) -> Path {
    let w = containerSize.width
    let h = containerSize.height
    let cw = cellSize.width
    let ch = cellSize.height
    
    guard w > 0, h > 0, cw > 0, ch > 0 else { return Path() }
    
    func verticalRange(offsetX: CGFloat) -> ClosedRange<Int> {
      // leftmost visible index … rightmost visible index (+1 as buffer)
      let start = Int(floor((-offsetX) / cw))
      let end = Int(ceil((w - offsetX) / cw))
      return start...end
    }
    
    func horizontalRange(offsetY: CGFloat) -> ClosedRange<Int> {
      let start = Int(floor((-offsetY) / ch))
      let end = Int(ceil((h - offsetY) / ch))
      return start...end
    }
    
    let offset: CGSize
    let colRange: ClosedRange<Int>
    let rowRange: ClosedRange<Int>
    
    switch mode {
      case .infinite(let o):
        offset = o
        colRange = verticalRange(offsetX: o.width)
        rowRange = horizontalRange(offsetY: o.height)
        
      case .bounded(let columns, let rows):
        offset = .zero
        colRange = 0...max(0, columns)
        rowRange = 0...max(0, rows)
    }
    
    return Path { p in
      // Vertical
      for i in colRange {
        let x = CGFloat(i) * cw + offset.width
        p.move(to: CGPoint(x: x, y: 0))
        p.addLine(to: CGPoint(x: x, y: h))
        onVerticalIndex?(i, x)
      }
      
      // Horizontal
      for i in rowRange {
        let y = CGFloat(i) * ch + offset.height
        p.move(to: CGPoint(x: 0, y: y))
        p.addLine(to: CGPoint(x: w, y: y))
      }
    }
  }
  
//  public static func createGrid(
//    columns: Int,
//    rows: Int,
//    cellSize: CGSize,
//    containerSize: CGSize
//  ) -> Path {
//    Path { p in
//      /// Horizontal lines
//      for row in 0...rows {
//        let y = min(CGFloat(row) * cellSize.height, containerSize.height)
//        p.move(to: CGPoint(x: 0, y: y))
//        p.addLine(to: CGPoint(x: containerSize.width, y: y))
//      }
//
//      /// Vertical lines
//      for column in 0...columns {
//        let x = min(CGFloat(column) * cellSize.width, containerSize.width)
//        p.move(to: CGPoint(x: x, y: 0))
//        p.addLine(to: CGPoint(x: x, y: containerSize.height))
//      }
//    }
//  }

  /// Appends a point marker shape at a given point with a visual radius.
  ///
  /// This helper computes the center-origin rect parameters and delegates to
  /// `PointShape.updatePath(center:radius:path:)` to avoid redundant geometry work.
  /// - Parameters:
  ///   - point: Center position where the marker should be drawn.
  ///   - shape: The marker shape to draw. Defaults to `.circle`.
  ///   - radius: The visual radius/half-extent for the marker.
  public mutating func addShape(
    at point: CGPoint,
    using shape: PointShape = .circle,
    radius: CGFloat,
  ) {
    shape.addShape(to: &self, at: point, radius: radius)
    //    shape.updatePath(center: point, radius: radius, path: &self)
  }
}
