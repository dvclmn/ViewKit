//
//  Ext+Path.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/10/2025.
//

import SwiftUI

extension Path {

  /// Creates a smooth Catmull-Rom spline through the given points.
  /// Uses cubic Bézier conversion for optimal rendering performance.
  public static func catmullRom(
    points: [CGPoint],
    variant: CatmullRomVariant = .centripetal,
    closed: Bool = false
  ) -> Path {
    guard points.count >= 2 else { return Path() }
    if points.count == 2 {
      return Path {
        $0.move(to: points[0])
        $0.addLine(to: points[1])
      }
    }

    var path = Path()
    let pts = closed ? points : extendEndpoints(points)

    path.move(to: pts[1])  // Start at first actual point

    for i in 1..<pts.count - 2 {
      let p0 = pts[i - 1]
      let p1 = pts[i]
      let p2 = pts[i + 1]
      let p3 = pts[i + 2]

      let (c1, c2) = CatmullRom.toCubicBezier(
        p0: p0, p1: p1, p2: p2, p3: p3,
        variant: variant
      )

      path.addCurve(to: p2, control1: c1, control2: c2)
    }

    if closed {
      // Close the loop by handling the wrap-around segments
      let (c1, c2) = CatmullRom.toCubicBezier(
        p0: pts[pts.count - 2], p1: pts[pts.count - 1], p2: pts[0], p3: pts[1],
        variant: variant
      )
      path.addCurve(to: pts[0], control1: c1, control2: c2)

      let (c1b, c2b) = CatmullRom.toCubicBezier(
        p0: pts[pts.count - 1], p1: pts[0], p2: pts[1], p3: pts[2],
        variant: variant
      )
      path.addCurve(to: pts[1], control1: c1b, control2: c2b)
    }

    return path
  }

  /// Samples points along the spline for hit-testing or vertex buffers
  public static func sampleCatmullRom(
    points: [CGPoint],
    variant: CatmullRomVariant = .centripetal,
    closed: Bool = false,
    samplesPerSegment: Int = 10
  ) -> [CGPoint] {
    guard points.count >= 2 else { return points }

    let pts = closed ? points : extendEndpoints(points)
    var result: [CGPoint] = []

    for i in 1..<(closed ? pts.count - 1 : pts.count - 2) {
      let p0 = pts[i - 1]
      let p1 = pts[i]
      let p2 = pts[i + 1]
      let p3 = pts[i + 2]

      for j in 0..<samplesPerSegment {
        let t = CGFloat(j) / CGFloat(samplesPerSegment)
        result.append(CatmullRom.point(p0: p0, p1: p1, p2: p2, p3: p3, t: t, variant: variant))
      }
    }

    if !closed {
      result.append(pts[pts.count - 2])  // Ensure we reach the end
    }

    return result
  }

  // MARK: - Helpers

  private static func extendEndpoints(_ points: [CGPoint]) -> [CGPoint] {
    // For open curves, duplicate endpoints so the curve starts/ends at the first/last point
    // You could also mirror them here if you want different endpoint behavior
    var extended = points
    extended.insert(points[0], at: 0)
    extended.append(points[points.count - 1])
    return extended
  }
}
//extension Path {
//
//  public static func catmullRomPath(
//    points: [CGPoint],
//    tension: CGFloat = 0.5,
//    closed: Bool = false,
//    samples: Int = 16
//  ) -> Path {
//    var path = Path()
//    guard points.count > 1 else { return path }
//
//    let n = points.count
//
//    // Start at first point
//    path.move(to: points[0])
//
//    for i in 0..<n - 1 {
//      var p0 = points[(i - 1 + n) % n]
//      let p1 = points[i]
//      let p2 = points[(i + 1) % n]
//      var p3 = points[(i + 2) % n]
//
//      // For open curves, don't wrap around
//      if !closed {
//        if i == 0 { p0 = p1 }
//        if i == n - 2 { p3 = p2 }
//      }
//
//      // Sample the curve between p1 and p2
//      for j in 1...samples {
//        let t = CGFloat(j) / CGFloat(samples)
//        let tt = t * t
//        let ttt = tt * t
//
//        let q0 = -tension * ttt + 2 * tension * tt - tension * t
//        let q1 = (2 - tension) * ttt + (tension - 3) * tt + 1
//        let q2 = (tension - 2) * ttt + (3 - 2 * tension) * tt + tension * t
//        let q3 = tension * ttt - tension * tt
//
//        let x = q0 * p0.x + q1 * p1.x + q2 * p2.x + q3 * p3.x
//        let y = q0 * p0.y + q1 * p1.y + q2 * p2.y + q3 * p3.y
//
//        path.addLine(to: CGPoint(x: x, y: y))
//      }
//    }
//
//    return path
//  }
//}
