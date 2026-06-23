//
//  Generator+Helpers.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/2/2026.
//

import SwiftUI

extension PathGenerator {
  /// This replaces existing points
  public mutating func updatePoints(_ newPoints: [CGPoint]) {
    points = newPoints
  }
  public mutating func resetPoints() {
    points.removeAll()
  }

  /// Private overload that allows passing in a stamper
  package mutating func processPath(
    with interpolation: CurveInterpolation,
    stamper: Stamper,
    path: inout Path
  ) {
    guard !points.isEmpty else { return }

    switch interpolation {
      case .linear:
        processLinear(shouldDropFirst: true, path: &path, stamped: stamper)

      case .cubic(let tension):
        processCubic(tension: tension, path: &path, stamped: stamper)

      case .quadratic(let midpoint, let bias):
        processQuadratic(
          midpoint: midpoint,
          cornerBias: bias,
          path: &path,
          stamped: stamper
        )

      case .catmullRom(let variant, let tension, let samples):
        catmullRomAlt02(
          variant: variant,
          tension: tension,
          closed: false,
          samples: samples,
          path: &path,
          stamped: stamper
        )

    }
    //    return path
  }

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
        // Default behaviour if no fallback provided: simple polyline
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
}
