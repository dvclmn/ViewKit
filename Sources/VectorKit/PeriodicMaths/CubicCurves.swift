//
//  CubicCurves.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/2/2026.
//

import Foundation

extension WavePathGenerator {

  /// Smooth path using cubic Bézier curves derived from Catmull–Rom.
  ///
  /// - Parameter tension: 0 = standard Catmull–Rom smoothing, 1 = straight lines.
  package func cubicPath(tension: CGFloat = 0) {
    guard points.count >= 2 else { return }

    path.move(to: points[0])

    // If tension is 1, it's effectively linear.
    if tension >= 1 {
      for p in points.dropFirst() { path.addLine(to: p) }
      return
    }

    let n = points.count
    let last = n - 1

    // Standard uniform Catmull–Rom => Bezier uses 1/6.
    // Tension scales that handle: higher tension => shorter handles => less overshoot.
    let handleScale: CGFloat = (1 - tension) / 6

    for i in 0..<(n - 1) {
      let p0 = points[max(i - 1, 0)]
      let p1 = points[i]
      let p2 = points[i + 1]
      let p3 = points[min(i + 2, last)]

      let c1 = CGPoint(
        x: p1.x + (p2.x - p0.x) * handleScale,
        y: p1.y + (p2.y - p0.y) * handleScale
      )

      let c2 = CGPoint(
        x: p2.x - (p3.x - p1.x) * handleScale,
        y: p2.y - (p3.y - p1.y) * handleScale
      )

      path.addCurve(to: p2, control1: c1, control2: c2)
    }
  }
}

//extension WavePathGenerator {
//
//  /// Creates a smooth path using cubic Bezier curves
//  /// Control points are calculated to create smooth transitions between segments
//  /// This provides good smoothness with reasonable performance
//  package func cubicPath() {
//    guard hasTwoOrMorePoints else {
//      return linearPath()
//    }
//
//    path.move(to: points[0])
//
//    if points.count == 2 {
//      path.addLine(to: points[1])
//      return
//    }
//
//    /// Calculate control points for smooth curves
//    let controlPoints = calculateCubicControlPoints()
//
//    for i in 0..<points.count - 1 {
//      let endPoint = points[i + 1]
//      let cp1 = controlPoints.first[i]
//      let cp2 = controlPoints.second[i]
//
//      path.addCurve(to: endPoint, control1: cp1, control2: cp2)
//      //      path.addCurve(to: endPoint, control1: cp1, control2: cp2)
//    }
//  }
//
//  /// Calculates control points for cubic Bezier interpolation
//  /// Uses a simplified algorithm that ensures C1 continuity (smooth first derivative)
//  package func calculateCubicControlPoints() -> (first: [CGPoint], second: [CGPoint]) {
//    let n = points.count - 1
//    var firstControlPoints: [CGPoint] = []
//    var secondControlPoints: [CGPoint] = []
//
//    /// Use a simplified method: place control points at 1/3 and 2/3 of the way
//    /// between consecutive points, adjusted for smoothness
//    for i in 0..<n {
//      let p0 = i > 0 ? points[i - 1] : points[i]
//      let p1 = points[i]
//      let p2 = points[i + 1]
//      let p3 = i < n - 1 ? points[i + 2] : points[i + 1]
//
//      /// Calculate direction vectors for smoothness
//      let d1x = p2.x - p0.x
//      let d1y = p2.y - p0.y
//      let d2x = p3.x - p1.x
//      let d2y = p3.y - p1.y
//
//      /// First control point (1/3 along, adjusted by direction)
//      let cp1 = CGPoint(
//        x: p1.x + d1x * 0.25,
//        y: p1.y + d1y * 0.25
//      )
//
//      /// Second control point (2/3 along, adjusted by direction)
//      let cp2 = CGPoint(
//        x: p2.x - d2x * 0.25,
//        y: p2.y - d2y * 0.25
//      )
//
//      firstControlPoints.append(cp1)
//      secondControlPoints.append(cp2)
//    }
//
//    return (firstControlPoints, secondControlPoints)
//  }
//
//  // MARK: - Another version, confusing
//
//  /// Smooth path using cubic Bézier curves
//  package func createCubicCurvePath() {
//    guard points.count >= 2 else { return }
//
//    path.move(to: points[0])
//
//    // Not enough points for cubic smoothing → fall back to lines
//    guard points.count >= 4 else {
//      for p in points.dropFirst() {
//        path.addLine(to: p)
//      }
//      return
//    }
//
//    for i in 0..<points.count - 3 {
//      let p0 = points[i]
//      let p1 = points[i + 1]
//      let p2 = points[i + 2]
//      let p3 = points[i + 3]
//
//      let (c1, c2) = cubicControls(p0: p0, p1: p1, p2: p2, p3: p3)
//
//      path.addCurve(
//        to: p2,
//        control1: c1,
//        control2: c2
//      )
//    }
//
//    /// Add final line to last point
//    if let last = points.last {
//      path.addLine(to: last)
//    }
//
//  }
//
//  private func cubicControls(
//    p0: CGPoint,
//    p1: CGPoint,
//    p2: CGPoint,
//    p3: CGPoint
//  ) -> (CGPoint, CGPoint) {
//
//    // Quarter influence, mirroring your quad logic
//    let c1 = CGPoint(
//      x: p1.x + (p2.x - p0.x) / 6,
//      y: p1.y + (p2.y - p0.y) / 6
//    )
//
//    let c2 = CGPoint(
//      x: p2.x - (p3.x - p1.x) / 6,
//      y: p2.y - (p3.y - p1.y) / 6
//    )
//
//    return (c1, c2)
//  }
//}
