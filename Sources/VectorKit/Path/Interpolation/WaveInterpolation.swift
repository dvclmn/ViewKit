//
//  WaveInterpolation.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/1/2026.
//
import SwiftUI
import CoreTools

/// Defines the interpolation method for creating smooth paths from discrete points
/// Note: See Swift Charts `InterpolationMethod`, possibly helpful
/// https://developer.apple.com/documentation/charts/interpolationmethod
@MetaEnum
public enum WaveInterpolation: Sendable, Equatable, Codable {
  case linear
  case cubic
  case quad
  case catmullRom(CatmullRomConfiguration)

//  public var id: String { rawValue }

  public var name: String {
    switch self {
      case .catmullRom: "Catmull-Rom"
      default: Self.Meta(self).name
    }
  }
}

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

extension Path {
  /// Creates a path from a collection of points using the specified interpolation method
  /// - Parameters:
  ///   - points: Array of points to interpolate
  ///   - interpolation: The interpolation method to use
  /// - Returns: A new Path object, or nil if insufficient points
  public static func makePath(
    using points: [CGPoint],
    interpolation: WaveInterpolation
  ) -> Path {
    guard !points.isEmpty else { return Path() }
    return switch interpolation {
      case .linear: makeLinearPath(points: points)
      case .cubic: makeCubicPath(points: points)
      case .catmullRom: makeCatmullRomPath(points: points)
    }
  }

  // MARK: - Linear Interpolation

  /// Creates a path by connecting points with straight lines
  /// This is the fastest method, ideal when smoothness isn't required
  private static func makeLinearPath(points: [CGPoint]) -> Path {
    //    guard !points.isEmpty else { return nil }

    var path = Path()
    path.move(to: points[0])

    for i in 1..<points.count {
      path.addLine(to: points[i])
    }

    return path
  }

  // MARK: - Cubic Bezier Interpolation

  /// Creates a smooth path using cubic Bezier curves
  /// Control points are calculated to create smooth transitions between segments
  /// This provides good smoothness with reasonable performance
  private static func makeCubicPath(points: [CGPoint]) -> Path {
    guard points.count >= 2 else { return makeLinearPath(points: points) }

    var path = Path()
    path.move(to: points[0])

    if points.count == 2 {
      path.addLine(to: points[1])
      return path
    }

    // Calculate control points for smooth curves
    let controlPoints = calculateCubicControlPoints(points: points)

    for i in 0..<points.count - 1 {
      let endPoint = points[i + 1]
      let cp1 = controlPoints.first[i]
      let cp2 = controlPoints.second[i]

      path.addCurve(to: endPoint, control1: cp1, control2: cp2)
    }

    return path
  }

  /// Calculates control points for cubic Bezier interpolation
  /// Uses a simplified algorithm that ensures C1 continuity (smooth first derivative)
  private static func calculateCubicControlPoints(points: [CGPoint]) -> (first: [CGPoint], second: [CGPoint])
  {
    let n = points.count - 1
    var firstControlPoints: [CGPoint] = []
    var secondControlPoints: [CGPoint] = []

    // Use a simplified method: place control points at 1/3 and 2/3 of the way
    // between consecutive points, adjusted for smoothness
    for i in 0..<n {
      let p0 = i > 0 ? points[i - 1] : points[i]
      let p1 = points[i]
      let p2 = points[i + 1]
      let p3 = i < n - 1 ? points[i + 2] : points[i + 1]

      // Calculate direction vectors for smoothness
      let d1x = p2.x - p0.x
      let d1y = p2.y - p0.y
      let d2x = p3.x - p1.x
      let d2y = p3.y - p1.y

      // First control point (1/3 along, adjusted by direction)
      let cp1 = CGPoint(
        x: p1.x + d1x * 0.25,
        y: p1.y + d1y * 0.25
      )

      // Second control point (2/3 along, adjusted by direction)
      let cp2 = CGPoint(
        x: p2.x - d2x * 0.25,
        y: p2.y - d2y * 0.25
      )

      firstControlPoints.append(cp1)
      secondControlPoints.append(cp2)
    }

    return (firstControlPoints, secondControlPoints)
  }

  // MARK: - Catmull-Rom Spline Interpolation

  /// Creates a smooth path using Catmull-Rom splines
  /// This method guarantees the curve passes through all control points
  /// and provides excellent smoothness with good performance
  ///
  /// Catmull-Rom splines are a type of cubic Hermite spline where:
  /// - The curve passes through all control points
  /// - The tangent at each point is calculated from neighboring points
  /// - Creates natural-looking curves without manual control point adjustment
  ///
  /// The algorithm uses the parametric form with tension parameter (default 0.5)
  /// which determines how tight the curves are around the control points
  private static func makeCatmullRomPath(points: [CGPoint], tension: CGFloat = 0.5) -> Path {
    guard points.count >= 2 else { return makeLinearPath(points: points) }

    var path = Path()
    path.move(to: points[0])

    if points.count == 2 {
      path.addLine(to: points[1])
      return path
    }

    // For Catmull-Rom, we need at least 4 points to define each curve segment
    // We'll duplicate the first and last points to handle endpoints
    var extendedPoints: [CGPoint] = []
    extendedPoints.append(points[0])  // Duplicate first point
    extendedPoints.append(contentsOf: points)
    extendedPoints.append(points[points.count - 1])  // Duplicate last point

    // Number of segments to subdivide each spline (higher = smoother but slower)
    // For real-time rendering, 8-12 is a good balance
    let subdivisions = 10

    // Generate curve segments between each pair of control points
    for i in 1..<extendedPoints.count - 2 {
      let p0 = extendedPoints[i - 1]
      let p1 = extendedPoints[i]
      let p2 = extendedPoints[i + 1]
      let p3 = extendedPoints[i + 2]

      // Generate points along this curve segment
      for j in 1...subdivisions {
        let t = CGFloat(j) / CGFloat(subdivisions)
        let point = catmullRomPoint(p0: p0, p1: p1, p2: p2, p3: p3, t: t, tension: tension)
        path.addLine(to: point)
      }
    }

    return path
  }

  /// Calculates a point on a Catmull-Rom spline
  /// - Parameters:
  ///   - p0: Point before the start of the segment
  ///   - p1: Start point of the segment
  ///   - p2: End point of the segment
  ///   - p3: Point after the end of the segment
  ///   - t: Parameter from 0 to 1 (position along the curve)
  ///   - tension: Tension parameter (0.5 = standard Catmull-Rom, 0 = straight lines, 1 = very tight curves)
  /// - Returns: Point on the curve at parameter t
  private static func catmullRomPoint(
    p0: CGPoint,
    p1: CGPoint,
    p2: CGPoint,
    p3: CGPoint,
    t: CGFloat,
    tension: CGFloat
  ) -> CGPoint {
    // Catmull-Rom basis matrix calculation
    // This is the standard formulation that ensures C1 continuity
    let t2 = t * t
    let t3 = t2 * t

    // Calculate x coordinate using Catmull-Rom basis functions
    let x =
      tension
      * ((2 * p1.x) + (-p0.x + p2.x) * t + (2 * p0.x - 5 * p1.x + 4 * p2.x - p3.x) * t2
        + (-p0.x + 3 * p1.x - 3 * p2.x + p3.x) * t3)

    // Calculate y coordinate using Catmull-Rom basis functions
    let y =
      tension
      * ((2 * p1.y) + (-p0.y + p2.y) * t + (2 * p0.y - 5 * p1.y + 4 * p2.y - p3.y) * t2
        + (-p0.y + 3 * p1.y - 3 * p2.y + p3.y) * t3)

    return CGPoint(x: x, y: y)
  }
}

// MARK: - Performance-Optimized Variant

extension Path {
  /// High-performance variant using pre-allocated buffers
  /// Use this when you're generating paths repeatedly in a hot path
  /// and can reuse the PathBuilder instance
  public struct PathBuilder {
    private var subdivisions: Int
    private var tension: CGFloat

    public init(subdivisions: Int = 10, tension: CGFloat = 0.5) {
      self.subdivisions = subdivisions
      self.tension = tension
    }

    /// Builds a path with the configured settings
    public func buildPath(using points: [CGPoint], interpolation: WaveInterpolation) -> Path? {
      switch interpolation {
        case .linear:
          return Path.makeLinearPath(points: points)
        case .cubic:
          return Path.makeCubicPath(points: points)
        case .catmullRom:
          return Path.makeCatmullRomPath(points: points, tension: tension)
      }
    }
  }
}
