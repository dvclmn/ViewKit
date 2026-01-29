//
//  WaveformPathGenerator.swift
//  AnimationVisualiser
//
//  Created by Dave Coleman on 17/11/2024.
//

import SwiftUI

struct WaveformPathGenerator {

  /// Creates a path from points using the specified style
  static func createPath(
    from points: [CGPoint], interpolation: PathInterpolationConfig = .defaultConfig(for: .linear)
  ) -> Path {
    switch interpolation.type {
      case .linear:
        return points.toPath(type: .line)
      case .quadCurve:
        return createQuadCurvePath(from: points)
      case .catmullRom:
        return createCatmullRomPath(from: points, tension: interpolation.tension)
    }
  }

  /// Smooth path using quadratic Bézier curves
  private static func createQuadCurvePath(from points: [CGPoint]) -> Path {
    Path { path in
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

  /// Smooth path using Catmull-Rom splines
  private static func createCatmullRomPath(from points: [CGPoint], tension: CGFloat) -> Path {
    Path { path in
      // Handle cases with too few points by drawing simple lines
      guard points.count >= 4 else {
        if let first = points.first {
          path.move(to: first)
          points.dropFirst().forEach { point in
            path.addLine(to: point)
          }
        }
        return
      }

      path.move(to: points[1])  // Start from second point

      for i in 1..<points.count - 2 {
        let p0 = points[i - 1]  // Previous point
        let p1 = points[i]  // Current point (start)
        let p2 = points[i + 1]  // Next point (end)
        let p3 = points[i + 2]  // Next next point

        /// Calculate Catmull-Rom control points
        /// Tension controls how tight the curve follows the points (0.0 to 1.0)
        let t01 = pow(sqrt(pow(p1.x - p0.x, 2) + pow(p1.y - p0.y, 2)), tension)
        let t12 = pow(sqrt(pow(p2.x - p1.x, 2) + pow(p2.y - p1.y, 2)), tension)
        let t23 = pow(sqrt(pow(p3.x - p2.x, 2) + pow(p3.y - p2.y, 2)), tension)

        let m1 = CGPoint(
          x: p1.x + (p2.x - p0.x) * t12 / (t01 + t12),
          y: p1.y + (p2.y - p0.y) * t12 / (t01 + t12)
        )

        let m2 = CGPoint(
          x: p2.x - (p3.x - p1.x) * t12 / (t12 + t23),
          y: p2.y - (p3.y - p1.y) * t12 / (t12 + t23)
        )

        path.addCurve(to: p2, control1: m1, control2: m2)
      }
    }
  }
}

// Separate movement calculation logic
struct MovementVector {

  static func randomWanderAlt(
    in range: ClosedRange<Double> = -50...50,
    frequency: Double = 1.0,
    chaos: Double = 0.3
  ) -> CGPoint {
    // Use different frequency offsets for x and y to create more organic movement
    let x = Double.oscillate(in: range, frequency: frequency * 1.0, chaos: chaos)
    let y = Double.oscillate(in: range, frequency: frequency * 1.3, chaos: chaos)
    return CGPoint(x: x, y: y)
  }

  static func randomWander(
    in range: ClosedRange<Double> = -50...50,
    frequency: Double = 1.0,
    chaos: Double = 0.3
  ) -> CGPoint {
    let now = Date().timeIntervalSinceReferenceDate

    // Create different oscillations for more organic movement
    func wave(_ frequency: Double, _ amplitude: Double) -> Double {
      sin(now * .pi * 2 * frequency) * amplitude
    }

    // X coordinate combines multiple waves
    let x =
      wave(frequency, 0.6) + wave(frequency * 1.3, 0.25) + wave(frequency * 2.7, 0.15) + Double.random(
        in: -1...1) * chaos

    // Y coordinate uses different frequencies for more natural movement
    let y =
      wave(frequency * 1.1, 0.6) + wave(frequency * 1.7, 0.25) + wave(frequency * 2.3, 0.15) + Double.random(
        in: -1...1) * chaos

    // Scale to desired range
    let middle = (range.upperBound + range.lowerBound) / 2
    let amplitude = (range.upperBound - range.lowerBound) / 2

    return CGPoint(
      x: middle + x * amplitude,
      y: middle + y * amplitude
    )
  }
}

struct SmoothNoiseEngine {

  var finalValue: Double = 0

  private var currentValue: Double = 0
  private var targetValue: Double = 0

  /// When 1, generate new target
  private var progress: Double = 1

  /// 0-1: How smooth the transitions are
  var smoothing: Double = 0.5

  /// How fast it changes
  var speed: Double = 1.0

  /// Overall magnitude
  var amplitude: Double = 1.0

  /// 0-1: How many secondary waves to add
  var complexity: Double = 0.5

  mutating func update(deltaTime: Double) {
    /// Generate new target when we reach the current one
    if progress >= 1 {
      targetValue = Double.random(in: -1...1)
      progress = 0
    }

    /// Update progress
    progress += deltaTime * speed

    /// Smooth interpolation using ease-in-out
    let smoothProgress = min(max(progress, 0), 1)
    let t = smoothProgress * smoothProgress * (3 - 2 * smoothProgress)

    let mainNoise = currentValue + (targetValue - currentValue) * t

    /// Add secondary waves based on complexity
    var secondaryNoise = 0.0
    if complexity > 0 {
      let fast = sin(progress * 8) * 0.2 * complexity
      let faster = sin(progress * 15) * 0.1 * complexity
      secondaryNoise = fast + faster
    }
    currentValue = mainNoise + secondaryNoise
    finalValue = currentValue * amplitude
  }

}

extension Double {

}
