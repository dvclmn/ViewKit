//
//  CubicCurves.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/2/2026.
//

import SwiftUI

extension WavePathGenerator {

  /// Smooth path using cubic Bézier curves derived from Catmull–Rom.
  ///
  /// - Parameter tension: 0 = standard Catmull–Rom smoothing, 1 = straight lines.
  package mutating func processCubic(
    tension: CGFloat = 0,
    path: inout Path,
    stamped: Stamped = { _, _, _ in }
  ) {
    let count = points.count
    if preparePathForNonLinearIfNeeded(path: &path) { return }

    /// If tension is 1, it's effectively linear.
    if tension >= 1 {
      return processLinear(path: &path, stamped: stamped)
    }

    let last = count - 1

    /// Standard uniform Catmull–Rom => Bezier uses 1/6.
    /// Tension scales that handle: higher tension => shorter handles => less overshoot.
    let handleScale: CGFloat = (1 - tension) / 6

    for i in 0..<(count - 1) {
      let p0 = points[max(i - 1, 0)]
      let p1 = points[i]
      let p2 = points[i + 1]
      let p3 = points[min(i + 2, last)]

      let c1 = CGPoint(
        x: p1.x + (p2.x - p0.x) * handleScale,
        y: p1.y + (p2.y - p0.y) * handleScale
      )

      let c2 = CGPoint(
        x: p2.x - (p3.x - p1.x) * handleScale,
        y: p2.y - (p3.y - p1.y) * handleScale
      )

      path.addCurve(to: p2, control1: c1, control2: c2)
    }
  }
}
