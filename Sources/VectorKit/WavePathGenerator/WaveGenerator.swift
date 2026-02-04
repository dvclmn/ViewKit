//
//  WaveformPathGenerator.swift
//  AnimationVisualiser
//
//  Created by Dave Coleman on 17/11/2024.
//

import SwiftUI

public struct WavePathGenerator {
  public var points: [CGPoint] = []
  //  var stamp: FloatPointStyle?
  //  var path: Path = .init()

  public init(points: [CGPoint] = []) {
    self.points = points
  }
}

package typealias Stamped = (
  _ index: Int?,
  _ point: CGPoint,
  _ path: inout Path
) -> Void

extension WavePathGenerator {

  /// Creates a path from a collection of points using the specified interpolation method
  /// - Parameters:
  ///   - points: Array of points to interpolate
  ///   - interpolation: The interpolation method to use
  /// - Returns: A new Path object, or nil if insufficient points
  public mutating func path(with interpolation: WaveInterpolation) -> Path {
    guard !points.isEmpty else { return Path() }

    var path = Path()

    switch interpolation {
      case .linear:
        processLinear(shouldDropFirst: true, path: &path)

      case .cubic(let tension):
        processCubic(tension: tension, path: &path)

      case .quadratic(let midpoint, let bias):
        processQuadratic(
          midpoint: midpoint,
          cornerBias: bias,
          path: &path
        )

      case .catmullRom(let variant, let tension, let samples):
        catmullRomAlt02(
          variant: variant,
          tension: tension,
          closed: false,
          samples: samples,
          path: &path
        )

    }
    return path
  }

  public mutating func path(with style: PathStyle) -> Path {
    //    self.stamp = style.stamped
    let stamper = makeStampClosure(from: style.stamped)
    return path(with: style.interpolation)
  }

  //  private mutating func processPath

  public mutating func resetPoints() {
    points.removeAll()
  }
}

extension WavePathGenerator {

  /// Prepares a Path for non-linear drawing given current points.
  /// - Returns: true if the caller should return early because the path was fully handled (0, 1, or 2 points). False means there are 3 or more points and caller should continue building a non-linear path.
  @discardableResult
  package mutating func preparePathForNonLinearIfNeeded(
    path: inout Path,
    minimumRequiredPoints: Int = 3,
    fallback: NonLinearPathFallback? = nil
  ) -> Bool {
    let count = points.count
    guard count >= 1 else { return true }  // nothing to draw

    if count == 1 {
      path.move(to: points[0])
      return true
    }

    if count == 2 {
      path.move(to: points[0])
      path.addLine(to: points[1])
      return true
    }

    /// If there are 3+ points but fewer than the minimum for the chosen interpolation,
    /// use fallback if provided, then early-return.
    if count < minimumRequiredPoints {
      // Ensure we start at the first point
      path.move(to: points[0])

      if let fb = fallback?.fallback {
        fb(&path, points, &self)
      } else {
        // Default behavior if no fallback provided: simple polyline
        for i in 1..<count {
          path.addLine(to: points[i])
        }
      }
      return true
    }

    // 3 or more points: move to first and let caller proceed
    path.move(to: points[0])
    return false
  }
  //  @discardableResult
  //  package mutating func preparePathForNonLinearIfNeeded(
  //    path: inout Path,
  //    minimumRequiredPoints: Int = 3,
  //    fallback: ((inout Path, [CGPoint]) -> Void)? = nil
  //  ) -> Bool {
  //    let count = points.count
  //    guard count >= 1 else { return true }  // nothing to draw
  //
  //    if count == 1 {
  //      path.move(to: points[0])
  //      return true
  //    }
  //
  //    if count == 2 {
  //      path.move(to: points[0])
  //      path.addLine(to: points[1])
  //      return true
  //    }
  //
  //    /// 3 or more points => caller continues to build non-linear path
  //    path.move(to: points[0])
  //    return false
  //  }
}

//struct NonLinearPathFallback {
//  let minRequiredPoints: Int
//  let fallback: ((inout Path, [CGPoint]) -> Void)? = nil
//}
//
//extension NonLinearPathFallback {
//
//}

/// Alternative; consider leaving WavePathGenerator out of this, and
/// just create a tiny polyline fallback instead
/// ```
/// { path, pts, _ in
///   guard let first = pts.first else { return }
///   path.move(to: first)
///   for p in pts.dropFirst() { path.addLine(to: p) }
/// }
/// ```
package typealias PathFallBack = (inout Path, [CGPoint], inout WavePathGenerator) -> Void
package struct NonLinearPathFallback {
  let minRequiredPoints: Int
  let fallback: PathFallBack?

  init(
    minRequiredPoints: Int,
    fallback: PathFallBack? = nil
  ) {
    self.minRequiredPoints = minRequiredPoints
    self.fallback = fallback
  }
}

extension NonLinearPathFallback {
  static var defaultLinear: NonLinearPathFallback {
    NonLinearPathFallback(minRequiredPoints: 4) {
      path,
      pts,
      generator in
      /// Temporarily swap generator points if needed
      let original = generator.points
      generator.points = pts
      defer { generator.points = original }

      /// Use linear processor as the fallback
      generator.processLinear(path: &path)
    }
  }
}
