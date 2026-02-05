//
//  WaveformPathGenerator.swift
//  AnimationVisualiser
//
//  Created by Dave Coleman on 17/11/2024.
//

import SwiftUI

public struct WavePathGenerator {
  public var points: [CGPoint]

  public init(points: [CGPoint] = []) {
    self.points = points
  }
}

package typealias Stamper = (
  _ index: Int?,
  _ point: CGPoint,
  _ path: inout Path
) -> Void

// MARK: - Create and return New Path
extension WavePathGenerator {
  /// Creates a path from a collection of points using the specified interpolation method
  /// - Parameters:
  ///   - points: Array of points to interpolate
  ///   - interpolation: The interpolation method to use
  /// - Returns: A new Path object, or nil if insufficient points
  public mutating func path(
    with interpolation: WaveInterpolation
  ) -> Path {
    var path = Path()
    processPath(with: interpolation, stamper: { _, _, _ in }, path: &path)
    return path
  }

  public mutating func path(withStyle style: PathStyle) -> Path {
    var path = Path()
    let stamper = makeStampClosure(from: style.stamped)
    processPath(with: style.interpolation, stamper: stamper, path: &path)
    return path
  }
}

// MARK: - Edit Existing Path
extension WavePathGenerator {
  public mutating func editPath(
    with interpolation: WaveInterpolation,
    path: inout Path
  ) {
    processPath(with: interpolation, stamper: { _, _, _ in }, path: &path)
  }
  
  public mutating func editPath(
    withStyle style: PathStyle,
    path: inout Path
  ) {
    let stamper = makeStampClosure(from: style.stamped)
    processPath(with: style.interpolation, stamper: stamper, path: &path)
  }
}
