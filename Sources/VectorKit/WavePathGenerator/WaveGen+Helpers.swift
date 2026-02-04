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
  public mutating func processPath(
    _ path: inout Path,
    with interpolation: WaveInterpolation
  ) {

    guard !points.isEmpty else { return }

    return switch interpolation {
      case .linear:
        processLinearPath(path: &path, shouldDropFirst: true)

      case .cubic(let tension): cubicPath(tension: tension)
//        usesAltCubicMethod ? createCubicCurvePath() : cubicPath()

      case .quadratic(let midpoint, let bias):
        processQuadPath(path: &path, cornerBias: bias)
//        createQuadCurvePath()

      case .catmullRom(let variant, let tension, let samples):
        catmullRomAlt02(variant: variant, tension: tension, closed: false, samples: samples)
    //        catmullRomAlt(tension: tension, closed: false, samples: samples)
    //        catmullRom(variant: variant, closed: false)
    }
  }

  // MARK: - Linear Interpolation

  /// Creates a path by connecting points with straight lines
  /// This is the fastest method, ideal when smoothness isn't required
  package mutating func processLinearPath(
    path: inout Path,
    shouldDropFirst: Bool = true
  ) {
    guard let firstPoint = points.first else { return }
    let lines = shouldDropFirst ? Array(points.dropFirst()) : points
    path.move(to: firstPoint)
    path.addLines(lines)
  }

  // MARK: - Cubic Bezier Interpolation

}
