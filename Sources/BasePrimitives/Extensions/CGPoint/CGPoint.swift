//
//  CGPoint.swift
//  Collection
//
//  Created by Dave Coleman on 16/11/2024.
//

import SwiftUI

//extension CGPoint: @retroactive Hashable {
//  public var hashValue: Int { x.hashValue << 32 ^ y.hashValue }
//}

//public func == (lhs: CGPoint, rhs: CGPoint) -> Bool {
//  return lhs.distance(to: rhs) < 0.000001
//}

extension Array where Element == CGPoint {

  /// Returns a view of every `stride`-th point, always including the first.
  public func sampled(every stride: Int) -> [CGPoint] {
    guard stride > 1, count > 1 else { return self }

    var result: [CGPoint] = []
    result.reserveCapacity(count / stride + 1)

    var i = 0
    while i < count {
      result.append(self[i])
      i += stride
    }

    // Optional: ensure last point is included
    if let last = last, result.last != last {
      result.append(last)
    }

    return result
  }
}

extension CGPoint {

  public init(_ x: CGFloat, _ y: CGFloat) {
    self.init(x: x, y: y)
  }
  
  /// Returns a new CGPoint aligned relative to a container of the given size,
  /// using a unit point as the anchor.
  ///
  /// Important: For this one, think of `self` as an offset or adjustment to be
  /// applied relative to the anchor point described by the `unitPoint`.
  ///
  /// For example, if you wanted to place something 10pts to the right and 5pts
  /// below the bottomTrailing of a 300×400 container:
  /// ```
  /// let offset = CGPoint(x: 10, y: 5)
  /// let result = offset.aligned(to: .bottomTrailing, in: CGSize(width: 300, height: 400))
  /// // → CGPoint(x: 310, y: 405)
  /// ```
  public func aligned(
    to unitPoint: UnitPoint,
    in containerSize: CGSize
  ) -> CGPoint {
    let anchor = CGPoint(
      x: unitPoint.x * containerSize.width,
      y: unitPoint.y * containerSize.height
    )
    return CGPoint(x: anchor.x + self.x, y: anchor.y + self.y)
  }

  /// Alternative to above `aligned(to:,in:)`
  /// This is aligning a `CGPoint` within a container, based on anchor.
  /// Aka shifts the current point so that it lands at the target anchor.
  ///
  /// Returns a new point positioned within a container so that this point
  /// becomes aligned to the specified anchor.
  public func repositioned(
    to unitPoint: UnitPoint,
    in containerSize: CGSize
  ) -> CGPoint {
    let anchor = CGPoint(
      x: unitPoint.x * containerSize.width,
      y: unitPoint.y * containerSize.height)
    return CGPoint(x: anchor.x - self.x, y: anchor.y - self.y)
  }

  /// Returns the closest named UnitPoint (e.g., .topLeading, .center, etc) within a given size.
  /// If the point is within a central region defined by tolerance, `.center` is returned.
  public func nearestAnchor(
    in size: CGSize,
    centerTolerance: CGFloat = 0.2
  ) -> UnitPoint {
    let relative = toUnitPoint(in: size)

    /// If close enough to center, return .center early
    let center = UnitPoint.center
    let dx = abs(relative.x - center.x)
    let dy = abs(relative.y - center.y)

    if dx <= centerTolerance / 2 && dy <= centerTolerance / 2 {
      return .center
    }

    let anchors: [UnitPoint] = [
      .topLeading, .top, .topTrailing,
      .leading, .trailing,
      .bottomLeading, .bottom, .bottomTrailing,
    ]

    return anchors.min(by: {
      distanceSquared(from: relative, to: $0) < distanceSquared(from: relative, to: $1)
    }) ?? .center
  }

  func distanceSquared(from a: UnitPoint, to b: UnitPoint) -> CGFloat {
    let dx = a.x - b.x
    let dy = a.y - b.y
    return dx * dx + dy * dy
  }
}

extension CGPoint {

  public static let quickPreset01 = CGPoint(x: 100, y: 50)
  public static let quickPreset02 = CGPoint(x: 80, y: 120)
  public static let quickPreset03 = CGPoint(x: 20, y: 220)

  /// What does this really mean/do?
  //  public var normalised: CGPoint {
  //    guard length > 0 else { return .zero }
  //    return CGPoint(
  //      x: x / length,
  //      y: y / length
  //    )
  //  }

  public func centredIn(size: CGSize) -> CGPoint {
    let centred: CGSize = size / 2
    return self - centred
  }
  
  func normalise() -> CGPoint {
    let l = length
    return CGPoint(x / l, y / l)
  }

  /// Previously: `sqrt(x * x + y * y)`
  public var length: CGFloat { hypot(x, y) }

  /// Below is equivalent to a previous version, which used
  /// `sqrt(pow(x - point.x, 2) + pow(y - point.y, 2))`
  ///
  /// This calculates Euclidean distance (straight-line distance)
  //  public func distance(to other: CGPoint) -> CGFloat {
  //    return hypot(other.x - x, other.y - y)
  //  }

  public func distance(to other: CGPoint) -> CGFloat {
    let dx = CGFloat(x - other.x)
    let dy = CGFloat(y - other.y)
    return sqrt((dx * dx) + (dy * dy))
  }

  /// Returns true if both x and y coordinates are in the range [0.0, 1.0]
  //  public var isNormalised: Bool {
  //    return x >= 0.0 && x <= 1.0 && y >= 0.0 && y <= 1.0
  //  }


  /// Standard Linear Interpolation (Lerp)
  /// Aligns with VectorArithmetic's logic.
  public func lerp(to end: CGPoint, t: CGFloat) -> CGPoint {
    CGPoint(
      x: x.interpolated(towards: end.x, amount: t),
      y: y.interpolated(towards: end.y, amount: t)
    )
  }

  /// Calculate the scaled movement from a previous point.
  /// Renamed from 'delta' to be more descriptive.
  public func scaledOffset(from lastPosition: CGPoint, sensitivity: CGFloat) -> CGVector {
    CGVector(
      dx: (self.x - lastPosition.x) * sensitivity,
      dy: (self.y - lastPosition.y) * sensitivity
    )
  }

  //  public func delta(
  //    from lastPosition: CGPoint,
  //    sensitivity: CGFloat = 1.0
  //  ) -> CGPoint {
  //    let result = CGPoint(
  //      x: (self.x - lastPosition.x) * sensitivity,
  //      y: (self.y - lastPosition.y) * sensitivity
  //    )
  //
  //    return result
  //  }

  public func midpoint(to other: Self) -> Self {
    lerp(to: other, t: 0.5)
  }
  
  public static func midPoint(
    from p1: CGPoint,
    to p2: CGPoint
  ) -> CGPoint {
    p1.lerp(to: p2, t: 0.5)
    //    return pointAlong(from: p1, to: p2, t: 0.5)
  }

  /// Find a point along the line between two points
  /// Example usage
  ///
  /// ```
  /// let point1 = CGPoint(x: 0, y: 0)
  /// let point2 = CGPoint(x: 100, y: 100)
  ///
  /// let midpoint = CGPoint.pointAlong(from: point1, to: point2, t: 0.5)
  /// print("Midpoint: \(midpoint)") // Should print (50, 50)
  ///
  /// let quarterPoint = point1.pointAlong(to: point2, t: 0.25)
  /// print("Quarter point: \(quarterPoint)") // Should print (25, 25)
  ///
  /// ```

  /// Returns a point along the line from this point to `end`.
  /// - Parameters:
  ///   - end: The ending point of the line.
  ///   - t: A factor determining the point's position along the line.
  ///        When t = 0, the result is this point.
  ///        When t = 1, the result is `end`.
  ///        Values less than 0 or greater than 1 will extrapolate beyond the line segment.
  /// - Returns: A point along the line from this point to `end`.
  //  public func pointAlong(to end: CGPoint, t: CGFloat) -> CGPoint {
  //    return CGPoint.pointAlong(from: self, to: end, t: t)
  //  }

  /// Returns a point at a specified distance along the line defined by `start` and `end`.
  /// - Parameters:
  ///   - start: The starting point of the line.
  ///   - end: The ending point of the line.
  ///   - distance: The absolute distance from the `start` point.
  /// - Returns: A point along the line defined by `start` and `end` at the specified distance.
  //  public static func pointAlong(
  //    from start: CGPoint,
  //    to end: CGPoint,
  //    distance: CGFloat
  //  ) -> CGPoint {
  //    let dx = end.x - start.x
  //    let dy = end.y - start.y
  //    let totalDistance = sqrt(dx * dx + dy * dy)
  //
  //    /// Calculate the unit vector in the direction from start to end
  //    let unitVectorX = dx / totalDistance
  //    let unitVectorY = dy / totalDistance
  //
  //    /// Calculate the new point at the specified distance
  //    return CGPoint(
  //      x: start.x + unitVectorX * distance,
  //      y: start.y + unitVectorY * distance
  //    )
  //  }

  /// Returns a point at a specified distance along the line from this point to `end`.
  /// - Parameters:
  ///   - end: The ending point of the line.
  ///   - distance: The absolute distance from this point.
  /// - Returns: A point along the line from this point to `end` at the specified distance.
  //  public func pointAlong(to end: CGPoint, distance: CGFloat) -> CGPoint {
  //    return CGPoint.pointAlong(from: self, to: end, distance: distance)
  //  }

}
