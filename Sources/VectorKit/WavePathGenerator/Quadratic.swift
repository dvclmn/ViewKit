//
//  Quadratic.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/2/2026.
//

import SwiftUI

enum QuadSmoothingStyle {
  case continuous  // Flowing / midpoint-based
  case articulated  // Corner aware/preserving, 3-point control
}

extension WavePathGenerator {

  /// t: 0 = flowing (midpoint), 1 = corner-aware (3-point influenced)
  package mutating func processQuadratic(
    midpoint midpointFactor: Double = 0.5,
    cornerBias t: Double = 0.5,
    path: inout Path,
    stamped: Stamper = { _, _, _ in }
  ) {
    let count = points.count
    if preparePathForNonLinearIfNeeded(path: &path) { return }

    let t = max(0, min(1, t))

    /// Curves to midpoints, controls blended between two policies.
    for i in 0..<(count - 2) {
      let p0 = points[i]
      let p1 = points[i + 1]
      let p2 = points[i + 2]

      let end = CGPoint(
        x: (p1.x + p2.x) * 0.5,
        y: (p1.y + p2.y) * 0.5)

      let cA = p1
      let cB = CGPoint(
        x: p1.x + (p0.x - p2.x) * 0.25,
        y: p1.y + (p0.y - p2.y) * 0.25)

      let control = CGPoint(
        x: cA.x + (cB.x - cA.x) * t,
        y: cA.y + (cB.y - cA.y) * t)

      path.addQuadCurve(to: end, control: control)
      stamped(i, end, &path)
    }

    /// Finish smoothly to the last point (avoid a final straight-line kink).
    path.addQuadCurve(to: points[count - 1], control: points[count - 2])
  }

  // MARK: - Alternate simpler method
  package mutating func processQuadraticSimple(
    midpointFactor: Double = 0.5,
    path: inout Path
  ) {
    let count = points.count
    if preparePathForNonLinearIfNeeded(path: &path) { return }

    for i in 1..<(count - 1) {
      let current = points[i]
      let next = points[i + 1]
      let mid = CGPoint(
        x: (current.x + next.x) * midpointFactor,
        y: (current.y + next.y) * midpointFactor)
      path.addQuadCurve(to: mid, control: current)
    }

    /// Finish with a quad curve to the last point
    path.addQuadCurve(to: points[count - 1], control: points[count - 2])
  }

  /// Smooth path using quadratic Bézier curves
  //  package mutating func createQuadCurvePath() {
  //
  //    guard points.count >= 2 else { return }
  //
  //    path.move(to: points[0])
  //
  //    for i in 0..<points.count - 2 {
  //      let p0 = points[i]
  //      let p1 = points[i + 1]
  //      let p2 = points[i + 2]
  //
  //      /// Calculate control point as midpoint between points
  //      // Calculate control point using both current and next segments
  //      // This creates a smoother transition between segments
  //      let control = CGPoint(
  //        x: p1.x + ((p0.x - p2.x) / 4),  // Use p2 to influence control point
  //        y: p1.y + ((p0.y - p2.y) / 4)  // Quarter distance for subtle curve
  //      )
  //
  //      path.addQuadCurve(to: p1, control: control)
  //    }
  //
  //    /// Add final line to last point
  //    if let last = points.last {
  //      path.addLine(to: last)
  //    }
  //
  //  }

}
