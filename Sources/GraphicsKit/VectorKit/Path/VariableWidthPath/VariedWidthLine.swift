//
//  VariedWidthLine.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/1/2026.
//

import SwiftUI

/// Convenience extension for common taper functions
/// Common width profiles for variable-width paths
public enum PathWidthProfile {
  case constant(CGFloat)
  case tapered(min: CGFloat, max: CGFloat)
  case custom((CGFloat) -> CGFloat)

  public func width(at t: CGFloat) -> CGFloat {
    switch self {
      case .constant(let w):
        return w / 2

      case .tapered(let min, let max):
        /// Tapered: thin at ends, thick in middle
        let half = max / 2
        let minHalf = min / 2
        let envelope = sin(t * .pi)  // 0 at ends, 1 at middle
        return minHalf + (half - minHalf) * envelope

      case .custom(let fn):
        return fn(t)
    }
  }
}

extension Path {

  public static func variableWidthPath(
    spine: Path,
    profile: PathWidthProfile,
    samples: Int,
  ) -> Path {
    Self.variableWidthPath(
      spine: spine,
      widthAt: { profile.width(at: $0) },
      samples: samples, )
  }

  //extension GraphicsContext {
  /// Creates a closed path with variable width along a spine path
  /// - Parameters:
  ///   - spine: The center path to follow
  ///   - widthAt: Closure that returns the half-width at a given parametric position (0...1)
  ///   - samples: Number of samples along the path for smooth curves
  /// - Returns: A closed path that can be filled
  private static func variableWidthPath(
    spine: Path,
    widthAt: @escaping (CGFloat) -> CGFloat,
    samples: Int,
  ) -> Path {
    var resultPath = Path()

    /// Sample points along the spine
    var spinePoints: [(point: CGPoint, tangent: CGPoint)] = []

    for i in 0...samples {
      let t = CGFloat(i) / CGFloat(samples)

      /// Get point at parameter t - handle edge cases
      let trimmedPath = spine.trimmedPath(from: 0, to: max(0.0001, t))
      guard let point = trimmedPath.currentPoint else {
        continue  // Skip invalid points instead of using .zero
      }

      /// Calculate tangent by looking at a small delta
      let delta = 0.01
      let t1 = max(0.0001, t - delta)
      let t2 = min(0.9999, t + delta)

      guard let p1 = spine.trimmedPath(from: 0, to: t1).currentPoint,
        let p2 = spine.trimmedPath(from: 0, to: t2).currentPoint
      else {
        continue
      }

      let dx = p2.x - p1.x
      let dy = p2.y - p1.y
      let length = hypot(dx, dy)

      let tangent: CGPoint
      guard length > 0.0001 else {
        /// If can't determine tangent, skip this point
        continue
      }
      tangent = CGPoint(x: dx / length, y: dy / length)
      spinePoints.append((point: point, tangent: tangent))
    }

    /// Don't proceed if not enough valid points
    guard spinePoints.count >= 2 else {
      return resultPath
    }

    /// Create offset points on both sides
    var leftSide: [CGPoint] = []
    var rightSide: [CGPoint] = []

    for i in 0..<spinePoints.count {
      let t = CGFloat(i) / CGFloat(max(1, spinePoints.count - 1))
      let halfWidth = widthAt(t)
      let point = spinePoints[i].point
      let tangent = spinePoints[i].tangent

      /// Perpendicular is tangent rotated 90 degrees
      let perpendicular = CGPoint(x: -tangent.y, y: tangent.x)

      let left = CGPoint(
        x: point.x + perpendicular.x * halfWidth,
        y: point.y + perpendicular.y * halfWidth,
      )
      let right = CGPoint(
        x: point.x - perpendicular.x * halfWidth,
        y: point.y - perpendicular.y * halfWidth,
      )

      leftSide.append(left)
      rightSide.append(right)
    }

    /// Build the closed path
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
