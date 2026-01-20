//
//  GeneratePoints.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/10/2025.
//

import Foundation
import CoreGraphics

extension Array where Element == CGPoint {
  public static func generateSpiral(
    start: CGPoint = .zero,
    turns: CGFloat = 1.5,
    maxRadius: CGFloat = 50,
    pointCount: Int = 60
  ) -> [CGPoint] {
    return start.generateSpiral(
      turns: turns,
      maxRadius: maxRadius,
      pointCount: pointCount
    )
  }
}
extension CGPoint {

  /// Generate a spiral as an array of points, starting from this point as center
  public func generateSpiral(
    turns: CGFloat = 1.5,
    maxRadius: CGFloat = 50,
    pointCount: Int = 60
  ) -> [CGPoint] {
    var points: [CGPoint] = []

    let angleStep = (turns * 2 * .pi) / CGFloat(pointCount - 1)

    for i in 0..<pointCount {
      let t = CGFloat(i) / CGFloat(pointCount - 1)  // 0 to 1
      let angle = angleStep * CGFloat(i)

      // Spiral grows outward as we progress
      let radius = maxRadius * t

      let x = self.x + radius * cos(angle)
      let y = self.y + radius * sin(angle)

      points.append(CGPoint(x: x, y: y))
    }

    return points
  }

  /// Alternative: Golden ratio spiral (more mathematically pure)
  public func generateGoldenSpiral(
    turns: CGFloat = 1.5,
    scale: CGFloat = 20,
    pointCount: Int = 60
  ) -> [CGPoint] {
    var points: [CGPoint] = []
    let phi: CGFloat = (1 + sqrt(5)) / 2  // Golden ratio

    for i in 0..<pointCount {
      let t = CGFloat(i) / CGFloat(pointCount - 1) * turns
      let angle = t * 2 * .pi

      // Golden spiral radius grows exponentially
      let radius = scale * pow(phi, t * 0.5)

      let x = self.x + radius * cos(angle)
      let y = self.y + radius * sin(angle)

      points.append(CGPoint(x: x, y: y))
    }

    return points
  }
}
