//
//  Quadratic.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/2/2026.
//

import SwiftUI

extension WavePathGenerator {

  /// Smooth path using quadratic Bézier curves
  package mutating func createQuadCurvePath() {

    guard points.count >= 2 else { return }

    path.move(to: points[0])

    for i in 0..<points.count - 2 {
      let p0 = points[i]
      let p1 = points[i + 1]
      let p2 = points[i + 2]

      /// Calculate control point as midpoint between points
      // Calculate control point using both current and next segments
      // This creates a smoother transition between segments
      let control = CGPoint(
        x: p1.x + ((p0.x - p2.x) / 4),  // Use p2 to influence control point
        y: p1.y + ((p0.y - p2.y) / 4)  // Quarter distance for subtle curve
      )

      path.addQuadCurve(to: p1, control: control)
    }

    /// Add final line to last point
    if let last = points.last {
      path.addLine(to: last)
    }

  }

}
