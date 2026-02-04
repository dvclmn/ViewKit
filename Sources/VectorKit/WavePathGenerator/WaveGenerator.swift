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

typealias Stamped = (
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
    let stamper = makeStampClosure(from: stamp)

    switch interpolation {
      case .linear:
        processLinear(shouldDropFirst: true)

      case .cubic(let tension):
        processCubic(tension: tension)

      case .quadratic(let midpoint, let bias):
        processQuadratic(midpoint: midpoint, cornerBias: bias)

      case .catmullRom(let variant, let tension, let samples):
        catmullRomAlt02(variant: variant, tension: tension, closed: false, samples: samples)

    }
    return self.path
  }

  public mutating func path(with style: PathStyle) -> Path {
    self.stamp = style.stamped
    return path(with: style.interpolation)
  }

  //  private mutating func processPath

  public mutating func resetPoints() {
    points.removeAll()
  }

  var hasTwoOrMorePoints: Bool { points.count >= 2 }
}

extension WavePathGenerator {

}
