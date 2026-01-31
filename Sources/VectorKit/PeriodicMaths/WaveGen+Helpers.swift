//
//  Path+Ext.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 29/1/2026.
//

import SwiftUI

extension WavePathGenerator {
  /// Creates a path from a collection of points using the specified interpolation method
  /// - Parameters:
  ///   - points: Array of points to interpolate
  ///   - interpolation: The interpolation method to use
  /// - Returns: A new Path object, or nil if insufficient points
  public func updatePath(with interpolation: WaveInterpolation) {
//  public func updatePath(with wave: ConfiguredWave) {
    //  ) -> Path {
    resetPath()

    guard !points.isEmpty else { return }

    return switch interpolation {
      case .linear:
        linearPath()

      case .cubic:
        usesAltCubicMethod ? createCubicCurvePath() : cubicPath()

      case .quadratic:
        createQuadCurvePath()

      case .catmullRom(let variant, let tension, let samples):
        catmullRomAlt02(variant: variant, tension: tension, closed: false, samples: samples)
    //        catmullRomAlt(tension: tension, closed: false, samples: samples)
    //        catmullRom(variant: variant, closed: false)
    }
  }

  // MARK: - Linear Interpolation

  /// Creates a path by connecting points with straight lines
  /// This is the fastest method, ideal when smoothness isn't required
  package func linearPath() {

    path.move(to: points[0])

    for i in 1..<points.count {
      path.addLine(to: points[i])
    }

  }

  // MARK: - Cubic Bezier Interpolation

  /// Creates a smooth path using cubic Bezier curves
  /// Control points are calculated to create smooth transitions between segments
  /// This provides good smoothness with reasonable performance
  package func cubicPath() {
    guard hasTwoOrMorePoints else {
      return linearPath()
    }

    path.move(to: points[0])

    if points.count == 2 {
      path.addLine(to: points[1])
      return
    }

    /// Calculate control points for smooth curves
    let controlPoints = calculateCubicControlPoints()

    for i in 0..<points.count - 1 {
      let endPoint = points[i + 1]
      let cp1 = controlPoints.first[i]
      let cp2 = controlPoints.second[i]

      path.addCurve(to: endPoint, control1: cp1, control2: cp2)
      //      path.addCurve(to: endPoint, control1: cp1, control2: cp2)
    }
  }

  /// Calculates control points for cubic Bezier interpolation
  /// Uses a simplified algorithm that ensures C1 continuity (smooth first derivative)
  package func calculateCubicControlPoints() -> (first: [CGPoint], second: [CGPoint]) {
    let n = points.count - 1
    var firstControlPoints: [CGPoint] = []
    var secondControlPoints: [CGPoint] = []

    /// Use a simplified method: place control points at 1/3 and 2/3 of the way
    /// between consecutive points, adjusted for smoothness
    for i in 0..<n {
      let p0 = i > 0 ? points[i - 1] : points[i]
      let p1 = points[i]
      let p2 = points[i + 1]
      let p3 = i < n - 1 ? points[i + 2] : points[i + 1]

      /// Calculate direction vectors for smoothness
      let d1x = p2.x - p0.x
      let d1y = p2.y - p0.y
      let d2x = p3.x - p1.x
      let d2y = p3.y - p1.y

      /// First control point (1/3 along, adjusted by direction)
      let cp1 = CGPoint(
        x: p1.x + d1x * 0.25,
        y: p1.y + d1y * 0.25
      )

      /// Second control point (2/3 along, adjusted by direction)
      let cp2 = CGPoint(
        x: p2.x - d2x * 0.25,
        y: p2.y - d2y * 0.25
      )

      firstControlPoints.append(cp1)
      secondControlPoints.append(cp2)
    }

    return (firstControlPoints, secondControlPoints)
  }

}
