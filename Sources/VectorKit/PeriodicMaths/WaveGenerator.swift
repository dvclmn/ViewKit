//
//  WaveformPathGenerator.swift
//  AnimationVisualiser
//
//  Created by Dave Coleman on 17/11/2024.
//

import SwiftUI

@Observable
public final class WaveGenerator {
  public var points: [CGPoint] = []
  public var path: Path = .init()
  public var interpolation: WaveInterpolation
  public var usesAltCubicMethod: Bool
  //  private var cachedControlPoints: [CGPoint]?

  public init(
    interpolation: WaveInterpolation = .cubic,
    usesAltCubicMethod: Bool = false
  ) {
    self.interpolation = interpolation
    self.usesAltCubicMethod = usesAltCubicMethod
  }
}

extension WaveGenerator {
  public func updateInterpolation(_ newInterpolation: WaveInterpolation) {
    interpolation = newInterpolation
    updatePath()
  }
  public func getPath(using points: [CGPoint], interpolation: WaveInterpolation) -> Path {
    self.points = points
    self.interpolation = interpolation
    updatePath()
    return path
  }

  public func resetAll() {
    resetPath()
    resetPoints()
  }
  public func resetPath() {
    path = .init()
  }
  public func resetPoints() {
    points.removeAll()
  }

  var hasTwoOrMorePoints: Bool { points.count >= 2 }
}

//public enum WaveError: Error {
//  case insufficientPointsToGeneratePath(String)
//}

// MARK: - Cached points
//extension WaveGenerator {
//  func setPoints(_ newPoints: [CGPoint]) {
//    points = newPoints
//    cachedControlPoints = nil // Invalidate on change
//  }
//
//  var controlPoints: [CGPoint] {
//    if let cached = cachedControlPoints { return cached }
//    let computed = calculateCubicControlPoints(from: points)
////    let computed = computeControlPoints(from: points)
//    cachedControlPoints = computed
//    return computed
//  }
//}

extension WaveGenerator {

  /// Creates a path from points using the specified style
  //  public func editPath(
  ////  static func createPath(
  ////    from points: [CGPoint],
  ////    interpolation: WaveInterpolation = .cubic
  //  ) {
  //    switch interpolation {
  //      case .linear: points.toPath(type: .line)
  //      case .cubic: createQuadCurvePath(from: points)
  //      case .catmullRom(let variant): catmullRom(variant: variant, closed: true)
  //    }
  //  }

  /// Smooth path using quadratic Bézier curves
  package func createQuadCurvePath() {

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

  /// Smooth path using cubic Bézier curves
  package func createCubicCurvePath() {
    guard points.count >= 2 else { return }

    path.move(to: points[0])

    // Not enough points for cubic smoothing → fall back to lines
    guard points.count >= 4 else {
      for p in points.dropFirst() {
        path.addLine(to: p)
      }
      return
    }

    for i in 0..<points.count - 3 {
      let p0 = points[i]
      let p1 = points[i + 1]
      let p2 = points[i + 2]
      let p3 = points[i + 3]

      let (c1, c2) = cubicControls(p0: p0, p1: p1, p2: p2, p3: p3)

      path.addCurve(
        to: p2,
        control1: c1,
        control2: c2
      )
    }

    /// Add final line to last point
    if let last = points.last {
      path.addLine(to: last)
    }

  }

  private func cubicControls(
    p0: CGPoint,
    p1: CGPoint,
    p2: CGPoint,
    p3: CGPoint
  ) -> (CGPoint, CGPoint) {

    // Quarter influence, mirroring your quad logic
    let c1 = CGPoint(
      x: p1.x + (p2.x - p0.x) / 6,
      y: p1.y + (p2.y - p0.y) / 6
    )

    let c2 = CGPoint(
      x: p2.x - (p3.x - p1.x) / 6,
      y: p2.y - (p3.y - p1.y) / 6
    )

    return (c1, c2)
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
    let x = Double.oscillate(in: range, frequency: frequency * 1.0, noise: chaos)
    let y = Double.oscillate(in: range, frequency: frequency * 1.3, noise: chaos)
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
