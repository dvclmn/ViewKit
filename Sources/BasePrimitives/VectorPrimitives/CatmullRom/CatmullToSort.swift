//
//  CatmullToSort.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 19/1/2026.
//

//import SwiftUI
//import CoreTools
//

//extension Path {
//  // MARK: - Catmull-Rom Spline Interpolation
//  
//  /// Creates a smooth path using Catmull-Rom splines
//  /// This method guarantees the curve passes through all control points
//  /// and provides excellent smoothness with good performance
//  ///
//  /// Catmull-Rom splines are a type of cubic Hermite spline where:
//  /// - The curve passes through all control points
//  /// - The tangent at each point is calculated from neighboring points
//  /// - Creates natural-looking curves without manual control point adjustment
//  ///
//  /// The algorithm uses the parametric form with tension parameter (default 0.5)
//  /// which determines how tight the curves are around the control points
//  package static func makeCatmullRomPath(
//    points: [CGPoint],
//    tension: CGFloat = 0.5
//  ) -> Path {
//    guard points.count >= 2 else { return makeLinearPath(points: points) }
//    
//    var path = Path()
//    path.move(to: points[0])
//    
//    if points.count == 2 {
//      path.addLine(to: points[1])
//      return path
//    }
//    
//    // For Catmull-Rom, we need at least 4 points to define each curve segment
//    // We'll duplicate the first and last points to handle endpoints
//    var extendedPoints: [CGPoint] = []
//    extendedPoints.append(points[0])  // Duplicate first point
//    extendedPoints.append(contentsOf: points)
//    extendedPoints.append(points[points.count - 1])  // Duplicate last point
//    
//    // Number of segments to subdivide each spline (higher = smoother but slower)
//    // For real-time rendering, 8-12 is a good balance
//    let subdivisions = 10
//    
//    // Generate curve segments between each pair of control points
//    for i in 1..<extendedPoints.count - 2 {
//      let p0 = extendedPoints[i - 1]
//      let p1 = extendedPoints[i]
//      let p2 = extendedPoints[i + 1]
//      let p3 = extendedPoints[i + 2]
//      
//      // Generate points along this curve segment
//      for j in 1...subdivisions {
//        let t = CGFloat(j) / CGFloat(subdivisions)
//        let point = catmullRomPoint(p0: p0, p1: p1, p2: p2, p3: p3, t: t, tension: tension)
//        path.addLine(to: point)
//      }
//    }
//    
//    return path
//  }
//  
//  /// Calculates a point on a Catmull-Rom spline
//  /// - Parameters:
//  ///   - p0: Point before the start of the segment
//  ///   - p1: Start point of the segment
//  ///   - p2: End point of the segment
//  ///   - p3: Point after the end of the segment
//  ///   - t: Parameter from 0 to 1 (position along the curve)
//  ///   - tension: Tension parameter (0.5 = standard Catmull-Rom, 0 = straight lines, 1 = very tight curves)
//  /// - Returns: Point on the curve at parameter t
//  private static func catmullRomPoint(
//    p0: CGPoint,
//    p1: CGPoint,
//    p2: CGPoint,
//    p3: CGPoint,
//    t: CGFloat,
//    tension: CGFloat
//  ) -> CGPoint {
//    // Catmull-Rom basis matrix calculation
//    // This is the standard formulation that ensures C1 continuity
//    let t2 = t * t
//    let t3 = t2 * t
//    
//    // Calculate x coordinate using Catmull-Rom basis functions
//    let x =
//    tension
//    * ((2 * p1.x) + (-p0.x + p2.x) * t + (2 * p0.x - 5 * p1.x + 4 * p2.x - p3.x) * t2
//       + (-p0.x + 3 * p1.x - 3 * p2.x + p3.x) * t3)
//    
//    // Calculate y coordinate using Catmull-Rom basis functions
//    let y =
//    tension
//    * ((2 * p1.y) + (-p0.y + p2.y) * t + (2 * p0.y - 5 * p1.y + 4 * p2.y - p3.y) * t2
//       + (-p0.y + 3 * p1.y - 3 * p2.y + p3.y) * t3)
//    
//    return CGPoint(x: x, y: y)
//  }
//}
