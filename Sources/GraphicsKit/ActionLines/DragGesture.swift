//
//  DragGesture.swift
//  Components
//
//  Created by Dave Coleman on 25/11/2024.
//


import SharedHelpers
import SwiftUI

#warning("Consider using GestureKit for gestures")

#if canImport(AppKit)
extension ActionLinesView {
  func dragGesture(
    in size: CGSize,
    with modifiers: Modifiers
  ) -> some Gesture {
    DragGesture(minimumDistance: 2)
      .onChanged { dragGesture in

        isDragging = true
        let isDraggingInner: Bool = modifiers.contains(.option)
        let isResizing: Bool = modifiers.contains(.shift)

        if lastDragPosition == nil {
          lastDragPosition = dragGesture.location

          if isDraggingInner {
            currentPointInner = handler.lines.innerShape.position ?? size.midpoint
          } else {
            currentPointOuter = handler.lines.outerShape.position ?? size.midpoint
          }
        }

        let deltaX = dragGesture.location.x - (lastDragPosition?.x ?? 0)
        let deltaY = dragGesture.location.y - (lastDragPosition?.y ?? 0)

        // Only use Y-axis movement for radius adjustment
        let radiusAdjustmentFactor: Double = -0.003  // Negative to make upward movement increase radius
        let radiusDelta = deltaY * radiusAdjustmentFactor

        let dampenedDeltaX: CGFloat = deltaX * dampening
        let dampenedDeltaY: CGFloat = deltaY * dampening

        if isResizing {
          if isDraggingInner {
            // Adjust inner radius
            let newRadius = (handler.lines.innerShape.radius + radiusDelta)
            //              .clamped(to: 0.05...0.95) // Prevent radius from becoming too small or too large
            handler.lines.innerShape.radius = newRadius
          } else {
            // Adjust outer radius
            let newRadius = (handler.lines.outerShape.radius + radiusDelta)
            //              .clamped(to: 0.2...1.5) // Prevent radius from becoming too small or too large
            handler.lines.outerShape.radius = newRadius
          }
        } else {
          // Handle position adjustment (existing code)
          if isDraggingInner {
            currentPointInner = CGPoint(
              x: currentPointInner.x + dampenedDeltaX,
              y: currentPointInner.y + dampenedDeltaY
            )
            handler.lines.innerShape.position = currentPointInner
          } else {
            currentPointOuter = CGPoint(
              x: currentPointOuter.x + dampenedDeltaX,
              y: currentPointOuter.y + dampenedDeltaY
            )
            handler.lines.outerShape.position = currentPointOuter
          }
        }

        lastDragPosition = dragGesture.location
      }
      .onEnded { _ in
        isDragging = false
        lastDragPosition = nil
      }
  }
}
#endif
