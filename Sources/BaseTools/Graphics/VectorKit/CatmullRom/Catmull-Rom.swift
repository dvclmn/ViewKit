//
//  Catmull-Rom.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 30/1/2026.
//

/// These have moved to `InteractionKit/GeometryPrimitives`
//import Foundation
//import InteractionKit

//extension CatmullRom {
//public struct CatmullRom {

  // MARK: - Point Evaluation

  /// Evaluate a single point on a Catmull-Rom spline segment
  /// - Parameters:
  ///   - p0,p1,p2,p3: Control points (p1 to p2 is the segment being evaluated)
  ///   - t: Parameter 0...1 along the segment
  ///   - variant: The parameterization style
  /// - Returns: Interpolated point
//  public static func point(
//    p0: CGPoint,
//    p1: CGPoint,
//    p2: CGPoint,
//    p3: CGPoint,
//    t: CGFloat,
//    variant: CatmullRom.SplineVariant = .centripetal
//  ) -> CGPoint {
//    
//    /// For uniform, we can use the optimized basis function form
//    if variant == .uniform {
//      return uniformBasis(p0: p0, p1: p1, p2: p2, p3: p3, t: t)
//    }
//
//    // For centripetal/chordal, compute knot vector
//    let alpha: CGFloat = variant.alpha
//    let t0: CGFloat = 0
//    let t1: CGFloat = knotValue(t0, p0, p1, alpha: alpha)
//    let t2: CGFloat = knotValue(t1, p1, p2, alpha: alpha)
//    let t3: CGFloat = knotValue(t2, p2, p3, alpha: alpha)
//
//    let tt = t1 + (t2 - t1) * t
//
//    let a1 = (t1 - tt) / (t1 - t0) * p0 + (tt - t0) / (t1 - t0) * p1
//    let a2 = (t2 - tt) / (t2 - t1) * p1 + (tt - t1) / (t2 - t1) * p2
//    let a3 = (t3 - tt) / (t3 - t2) * p2 + (tt - t2) / (t3 - t2) * p3
//
//    let b1 = (t2 - tt) / (t2 - t0) * a1 + (tt - t0) / (t2 - t0) * a2
//    let b2 = (t3 - tt) / (t3 - t1) * a2 + (tt - t1) / (t3 - t1) * a3
//
//    return (t2 - tt) / (t2 - t1) * b1 + (tt - t1) / (t2 - t1) * b2
//  }

  /// Scalar version for animating single values
//  public static func scalar(
//    v0: CGFloat, v1: CGFloat, v2: CGFloat, v3: CGFloat,
//    t: CGFloat,
//    variant: CatmullRom.SplineVariant = .centripetal
//  ) -> CGFloat {
//    if variant == .uniform {
//      // Optimized uniform basis
//      let t2 = t * t
//      let t3 = t2 * t
//      return 0.5
//        * (2 * v1 + (-v0 + v2) * t + (2 * v0 - 5 * v1 + 4 * v2 - v3) * t2 + (-v0 + 3 * v1 - 3 * v2 + v3) * t3)
//    }
//
//    // Generic implementation via point evaluation (CGPoint is fine for scalars)
//    let p = point(
//      p0: CGPoint(x: v0, y: 0),
//      p1: CGPoint(x: v1, y: 0),
//      p2: CGPoint(x: v2, y: 0),
//      p3: CGPoint(x: v3, y: 0),
//      t: t,
//      variant: variant
//    )
//    return p.x
//  }

  // MARK: - Cubic Bézier Conversion

  /// Converts a Catmull-Rom segment to a cubic Bézier curve.
  /// This is the most efficient way to draw C-R splines in Core Graphics.
//  public static func toCubicBezier(
//    p0: CGPoint, p1: CGPoint, p2: CGPoint, p3: CGPoint,
//    variant: CatmullRom.SplineVariant = .centripetal
//  ) -> (c1: CGPoint, c2: CGPoint) {
//    let alpha = variant.alpha
//
//    let d1 = p0.distance(to: p1)
//    let d2 = p1.distance(to: p2)
//    let d3 = p2.distance(to: p3)
//
//    let d1α = pow(d1, alpha)
//    let d2α = pow(d2, alpha)
//    let d3α = pow(d3, alpha)
//
//    // Avoid division by zero on coincident points
//    guard d1α + d2α > 0, d2α + d3α > 0 else {
//      return (c1: p1, c2: p2)
//    }
//
//    let m1 = CGPoint(
//      x: p2.x - (p2.x - p0.x) * d2α / (3 * (d1α + d2α)) - p1.x,
//      y: p2.y - (p2.y - p0.y) * d2α / (3 * (d1α + d2α)) - p1.y
//    )
//    let m2 = CGPoint(
//      x: p1.x + (p3.x - p1.x) * d2α / (3 * (d2α + d3α)) - p2.x,
//      y: p1.y + (p3.y - p1.y) * d2α / (3 * (d2α + d3α)) - p2.y
//    )
//
//    return (
//      c1: CGPoint(x: p1.x + m1.x, y: p1.y + m1.y),
//      c2: CGPoint(x: p2.x - m2.x, y: p2.y - m2.y)
//    )
//  }

  // MARK: - Private Helpers

//  private static func knotValue(_ ti: CGFloat, _ pi: CGPoint, _ pj: CGPoint, alpha: CGFloat) -> CGFloat {
//    let d = hypot(pj.x - pi.x, pj.y - pi.y)
//    return ti + pow(d, alpha)
//  }
//
//  private static func uniformBasis(p0: CGPoint, p1: CGPoint, p2: CGPoint, p3: CGPoint, t: CGFloat) -> CGPoint
//  {
//    let t2 = t * t
//    let t3 = t2 * t
//
//    // Standard Catmull-Rom basis matrix with 0.5 factor
//    let b0 = -0.5 * t3 + t2 - 0.5 * t
//    let b1 = 1.5 * t3 - 2.5 * t2 + 1.0
//    let b2 = -1.5 * t3 + 2.0 * t2 + 0.5 * t
//    let b3 = 0.5 * t3 - 0.5 * t2
//
//    return CGPoint(
//      x: b0 * p0.x + b1 * p1.x + b2 * p2.x + b3 * p3.x,
//      y: b0 * p0.y + b1 * p1.y + b2 * p2.y + b3 * p3.y
//    )
//  }
//}

// MARK: - CGPoint Helpers

//extension CGPoint {
//  fileprivate static func * (lhs: CGFloat, rhs: CGPoint) -> CGPoint {
//    CGPoint(x: lhs * rhs.x, y: lhs * rhs.y)
//  }
//
//  fileprivate static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
//    CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
//  }
//
////  fileprivate func distance(to other: CGPoint) -> CGFloat {
////    hypot(other.x - x, other.y - y)
////  }
//}
