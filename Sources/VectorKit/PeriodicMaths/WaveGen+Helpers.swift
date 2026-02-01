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
    resetPath()

    guard !points.isEmpty else { return }

    return switch interpolation {
      case .linear:
        linearPath()

      case .cubic(let tension): cubicPath(tension: tension)
//        usesAltCubicMethod ? createCubicCurvePath() : cubicPath()

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

}
