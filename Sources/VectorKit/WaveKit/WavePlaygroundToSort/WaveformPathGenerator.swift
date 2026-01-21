//
//  WaveformPathGenerator.swift
//  AnimationVisualiser
//
//  Created by Dave Coleman on 17/11/2024.
//

import SwiftUI


//struct WaveformPathGenerator {
//  
//  /// Creates a path from points using the specified style
//  static func createPath(from points: [CGPoint], interpolation: PathInterpolationConfig = .defaultConfig(for: .linear)) -> Path {
//    switch interpolation.type {
//      case .linear:
//        return points.toPath(type: .line)
//      case .quadCurve:
//        return createQuadCurvePath(from: points)
//      case .catmullRom:
//        return createCatmullRomPath(from: points, tension: interpolation.tension)
//    }
//  }
//  
//  /// Smooth path using quadratic Bézier curves
//  private static func createQuadCurvePath(from points: [CGPoint]) -> Path {
//    Path { path in
//      guard points.count >= 2 else { return }
//      
//      path.move(to: points[0])
//      
//      for i in 0..<points.count - 2 {
//        let p0 = points[i]
//        let p1 = points[i + 1]
//        let p2 = points[i + 2]
//        
//        /// Calculate control point as midpoint between points
//        // Calculate control point using both current and next segments
//        // This creates a smoother transition between segments
//        let control = CGPoint(
//          x: p1.x + ((p0.x - p2.x) / 4),  // Use p2 to influence control point
//          y: p1.y + ((p0.y - p2.y) / 4)   // Quarter distance for subtle curve
//        )
//        
//        
//        path.addQuadCurve(to: p1, control: control)
//      }
//      
//      /// Add final line to last point
//      if let last = points.last {
//        path.addLine(to: last)
//      }
//    }
//  }
//  
//  /// Smooth path using Catmull-Rom splines
//  private static func createCatmullRomPath(from points: [CGPoint], tension: CGFloat) -> Path {
//    Path { path in
//      // Handle cases with too few points by drawing simple lines
//      guard points.count >= 4 else {
//        if let first = points.first {
//          path.move(to: first)
//          points.dropFirst().forEach { point in
//            path.addLine(to: point)
//          }
//        }
//        return
//      }
//      
//      path.move(to: points[1])  // Start from second point
//      
//      for i in 1..<points.count - 2 {
//        let p0 = points[i - 1]  // Previous point
//        let p1 = points[i]      // Current point (start)
//        let p2 = points[i + 1]  // Next point (end)
//        let p3 = points[i + 2]  // Next next point
//        
//        /// Calculate Catmull-Rom control points
//        /// Tension controls how tight the curve follows the points (0.0 to 1.0)
//        let t01 = pow(sqrt(pow(p1.x - p0.x, 2) + pow(p1.y - p0.y, 2)), tension)
//        let t12 = pow(sqrt(pow(p2.x - p1.x, 2) + pow(p2.y - p1.y, 2)), tension)
//        let t23 = pow(sqrt(pow(p3.x - p2.x, 2) + pow(p3.y - p2.y, 2)), tension)
//        
//        let m1 = CGPoint(
//          x: p1.x + (p2.x - p0.x) * t12 / (t01 + t12),
//          y: p1.y + (p2.y - p0.y) * t12 / (t01 + t12)
//        )
//        
//        let m2 = CGPoint(
//          x: p2.x - (p3.x - p1.x) * t12 / (t12 + t23),
//          y: p2.y - (p3.y - p1.y) * t12 / (t12 + t23)
//        )
//        
//        path.addCurve(to: p2, control1: m1, control2: m2)
//      }
//    }
//  }
//}
