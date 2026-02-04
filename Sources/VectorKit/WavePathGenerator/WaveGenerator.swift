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
          samples: samples
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
  package mutating func preparePathForNonLinearIfNeeded(path: inout Path) -> Bool {
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

    /// 3 or more points => caller continues to build non-linear path
    path.move(to: points[0])
    return false
  }
}
