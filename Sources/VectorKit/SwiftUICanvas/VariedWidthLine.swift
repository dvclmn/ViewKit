//
//  VariedWidthLine.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/1/2026.
//

import SwiftUI

extension GraphicsContext {
  /// Creates a closed path with variable width along a spine path
  /// - Parameters:
  ///   - spine: The center path to follow
  ///   - widthAt: Closure that returns the half-width at a given parametric position (0...1)
  ///   - samples: Number of samples along the path for smooth curves
  /// - Returns: A closed path that can be filled
  public func variableWidthPath(
    spine: Path,
    widthAt: @escaping (Double) -> CGFloat,
    samples: Int = 50
  ) -> Path {
    var resultPath = Path()

    // Sample points along the spine
    var spinePoints: [(point: CGPoint, tangent: CGPoint)] = []

    for i in 0...samples {
      let t = Double(i) / Double(samples)

      // Get point at parameter t
      let point = spine.trimmedPath(from: 0, to: t).currentPoint ?? .zero

      // Calculate tangent by looking at a small delta
      let delta = 0.001
      let t1 = max(0, t - delta)
      let t2 = min(1, t + delta)
      let p1 = spine.trimmedPath(from: 0, to: t1).currentPoint ?? point
      let p2 = spine.trimmedPath(from: 0, to: t2).currentPoint ?? point

      let dx = p2.x - p1.x
      let dy = p2.y - p1.y
      let length = hypot(dx, dy)

      let tangent: CGPoint
      if length > 0.0001 {
        tangent = CGPoint(x: dx / length, y: dy / length)
      } else {
        tangent = CGPoint(x: 1, y: 0)
      }

      spinePoints.append((point: point, tangent: tangent))
    }

    // Create offset points on both sides
    var leftSide: [CGPoint] = []
    var rightSide: [CGPoint] = []

    for i in 0..<spinePoints.count {
      let t = Double(i) / Double(samples)
      let halfWidth = widthAt(t)
      let point = spinePoints[i].point
      let tangent = spinePoints[i].tangent

      // Perpendicular is tangent rotated 90 degrees
      let perpendicular = CGPoint(x: -tangent.y, y: tangent.x)

      let left = CGPoint(
        x: point.x + perpendicular.x * halfWidth,
        y: point.y + perpendicular.y * halfWidth
      )
      let right = CGPoint(
        x: point.x - perpendicular.x * halfWidth,
        y: point.y - perpendicular.y * halfWidth
      )

      leftSide.append(left)
      rightSide.append(right)
    }

    // Build the closed path
    if !leftSide.isEmpty {
      resultPath.move(to: leftSide[0])
      for point in leftSide.dropFirst() {
        resultPath.addLine(to: point)
      }
      for point in rightSide.reversed() {
        resultPath.addLine(to: point)
      }
      resultPath.closeSubpath()
    }

    return resultPath
  }
}

// Convenience extension for common taper functions
extension GraphicsContext {
  /// Common width profiles for variable-width paths
  public enum WidthProfile {
    case constant(CGFloat)
    case tapered(min: CGFloat, max: CGFloat)
    case custom((Double) -> CGFloat)

    public func width(at t: Double) -> CGFloat {
      switch self {
        case .constant(let w):
          return w / 2
        case .tapered(let min, let max):
          // Tapered: thin at ends, thick in middle
          let half = max / 2
          let minHalf = min / 2
          let envelope = sin(t * .pi)  // 0 at ends, 1 at middle
          return minHalf + (half - minHalf) * envelope
        case .custom(let fn):
          return fn(t)
      }
    }
  }

  public func variableWidthPath(
    spine: Path,
    profile: WidthProfile,
    samples: Int = 50
  ) -> Path {
    variableWidthPath(spine: spine, widthAt: { profile.width(at: $0) }, samples: samples)
  }
}
