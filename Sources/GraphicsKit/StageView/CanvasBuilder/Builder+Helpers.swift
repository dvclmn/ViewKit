//
//  Builder+Helpers.swift
//  BaseDemos
//
//  Created by Dave Coleman on 2/2/2026.
//

import Foundation

extension CheckerBoardBuilder {

  package func distort(_ p: CGPoint) -> CGPoint {
    config.distortion.distort(
      p,
      vanishingPoint: absVanishingPoint
    )
  }

  /// Core primitive: axis-aligned bounding box for a set of points
  @inline(__always)
  package func boundingBox(of corners: [CGPoint]) -> CGRect {
    guard !corners.isEmpty else { return .null }
    var minX = corners[0].x
    var maxX = corners[0].x
    var minY = corners[0].y
    var maxY = corners[0].y
    for i in 1..<corners.count {
      let p = corners[i]
      if p.x < minX { minX = p.x }
      if p.x > maxX { maxX = p.x }
      if p.y < minY { minY = p.y }
      if p.y > maxY { maxY = p.y }
    }
    return CGRect(x: minX, y: minY, width: max(0, maxX - minX), height: max(0, maxY - minY))
  }

  /// Core visibility primitive: does the quad's bbox intersect the screen rect expanded by `margin`?
  @inline(__always)
  package func intersectsScreen(
    corners: [CGPoint],
    margin: CGFloat = 0
  ) -> Bool {
    let box = boundingBox(of: corners)
    if box.isNull || box.isEmpty { return false }
    let rect = CGRect(origin: .zero, size: size).insetBy(dx: -margin, dy: -margin)
    return box.intersects(rect)
  }

  /// Near-edge band semantics: inside the expanded rect but not inside the contracted rect
  @inline(__always)
  package func isNearScreenEdge(corners: [CGPoint], edgeThreshold: CGFloat = 8) -> Bool {
    let box = boundingBox(of: corners)
    if box.isNull || box.isEmpty { return false }
    let screen = CGRect(origin: .zero, size: size)
    let edge = max(0, edgeThreshold)
    let outer = screen.insetBy(dx: -edge, dy: -edge)  // expanded
    let inner = screen.insetBy(dx: +edge, dy: +edge)  // contracted
    return box.intersects(outer) && !box.intersects(inner)
  }

  /// Wrapper for clarity, preserving existing call sites
  @inline(__always)
  package func isQuadVisible(corners: [CGPoint]) -> Bool {
    return intersectsScreen(corners: corners, margin: 0)
  }

  /// Simple polygon area as a proxy for near-cull (very small or sliver quads)
  func polygonArea(_ pts: [CGPoint]) -> CGFloat {
    guard pts.count >= 3 else { return 0 }
    var a: CGFloat = 0
    for i in 0..<pts.count {
      let j = (i + 1) % pts.count
      a += pts[i].x * pts[j].y - pts[j].x * pts[i].y
    }
    return abs(a) * 0.5
  }

  func isNearCull(transformedCorners: [CGPoint]) -> Bool {
    guard debugEnabled else { return false }
    let area = polygonArea(transformedCorners)
    return area < max(0, nearCullAreaThreshold)
  }

  package func sequence(center: Int, min: Int, max: Int) -> [Int] {
    var result: [Int] = []
    result.reserveCapacity(max - min + 1)
    var left = center
    var right = center + 1
    while left >= min || right <= max {
      if left >= min {
        result.append(left)
        left -= 1
      }
      if right <= max {
        result.append(right)
        right += 1
      }
    }
    return result
  }
}
