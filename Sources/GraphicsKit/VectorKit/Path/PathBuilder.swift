//
//  PathBuilder.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 29/1/2026.
//

import SwiftUI

/// Example demonstrating different interpolation methods
/// ```
/// static func exampleUsage() {
///   let points = [
///     CGPoint(x: 50, y: 100),
///     CGPoint(x: 100, y: 50),
///     CGPoint(x: 150, y: 120),
///     CGPoint(x: 200, y: 80),
///     CGPoint(x: 250, y: 110)
///   ]
///
///   // Linear interpolation (fastest, straight lines)
///   let linearPath = Path.makePath(using: points, interpolation: .linear)
///
///   // Cubic Bezier (smooth, good performance)
///   let cubicPath = Path.makePath(using: points, interpolation: .cubic)
///
///   // Catmull-Rom spline (smoothest, passes through all points)
///   let catmullRomPath = Path.makePath(using: points, interpolation: .catmullRom)
///
///   // High-performance repeated usage
///   let builder = Path.PathBuilder(subdivisions: 10, tension: 0.5)
///   let optimizedPath = builder.buildPath(using: points, interpolation: .catmullRom)
/// }
/// ```

/// High-performance variant using pre-allocated buffers
/// Use this when you're generating paths repeatedly in a hot path
/// and can reuse the PathBuilder instance
//public struct PathBuilder {
//  private var subdivisions: Int
//  private var tension: CGFloat
//
//  public init(subdivisions: Int = 10, tension: CGFloat = 0.5) {
//    self.subdivisions = subdivisions
//    self.tension = tension
//  }
//
//  /// Builds a path with the configured settings
//  public func buildPath(
//    using points: [CGPoint],
//    interpolation: CurveInterpolation
//  ) -> Path? {
//    switch interpolation {
//      case .linear: Path.makeLinearPath(points: points)
//      case .cubic: Path.makeCubicPath(points: points)
//      //      case .quad: Path.makeCubicPath(points: points)
//      case .catmullRom: Path.makeCatmullRomPath(points: points, tension: tension)
//    }
//  }
//}
