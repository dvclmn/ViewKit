//
//  SingleGridAxis.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/4/2026.
//

import SwiftUI
import GridPrimitives
import BasePrimitives

extension Path {
  
  /// Draws a sequence of parallel lines along a specified axis.
  package mutating func addGridAxis(
    _ axis: GeometryAxis,
    range: ClosedRange<Int>,
    cellSize: CGFloat,
    panningOffset: CGFloat,
    gridOrigin: CGPoint,
    crossLength: CGFloat,     // How long the line should be drawn
    containerLimit: CGFloat,  // The max dimension for edge checks
    drawsBorder: Bool,
    edgeEpsilon: CGFloat = 0.5,
    onIndex: ((GridLine) -> Void)? = nil
  ) {
    guard range.lowerBound <= range.upperBound else { return }
    
    for i in range {
      // Calculate the scalar position along the varying axis
      let position = CGFloat(i) * cellSize + panningOffset
      
      // Global bounds check (crucial for infinite, harmless for bounded)
      guard position >= -edgeEpsilon, position <= containerLimit + edgeEpsilon else { continue }
      
      // Border check
      let isOnEdge = abs(position - 0) <= edgeEpsilon || abs(position - containerLimit) <= edgeEpsilon
      if !drawsBorder && isOnEdge { continue }
      
      // Map the 1D position into 2D space based on the axis
      let startPoint: CGPoint
      let endPoint: CGPoint
      
      if axis == .horizontal {
        // Progressing along X (Drawing vertical lines/columns)
        startPoint = CGPoint(x: position + gridOrigin.x, y: gridOrigin.y)
        endPoint = CGPoint(x: position + gridOrigin.x, y: gridOrigin.y + crossLength)
      } else {
        // Progressing along Y (Drawing horizontal lines/rows)
        startPoint = CGPoint(x: gridOrigin.x, y: position + gridOrigin.y)
        endPoint = CGPoint(x: gridOrigin.x + crossLength, y: position + gridOrigin.y)
      }
      
      self.move(to: startPoint)
      self.addLine(to: endPoint)
      
      if let onIndex {
        let line = GridLine(axis: axis, index: i, position: position)
        onIndex(line)
      }
    }
  }
}
