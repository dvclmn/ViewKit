//
//  ShiftPoint.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 8/10/2025.
//

import SwiftUI

extension CGPoint {

  public func distanceSquared(
//    from point1: CGPoint,
    to point2: CGPoint
  ) -> CGFloat {
    let dx = x - point2.x
    let dy = y - point2.y
    return dx * dx + dy * dy
  }

  /// Moves a point toward a target by a fixed absolute distance.
  /// Great for constant-speed movement.
  public func moveTowards(_ target: CGPoint, distance: CGFloat) -> CGPoint {
    let dx = target.x - self.x
    let dy = target.y - self.y
    let totalDistance = sqrt(dx * dx + dy * dy)

    /// Safety check: If we are already there or the distance is 0, just return self.
    if totalDistance == 0 || distance == 0 { return self }

    /// If the distance to move is greater than the actual distance,
    /// we might want to cap it to the target (optional).
    let safeDistance = min(distance, totalDistance)

    let t = safeDistance / totalDistance
    return self.lerp(to: target, t: t)
  }

  /// Shift right (increases x)
  public func shiftedRight(by distance: CGFloat) -> CGPoint {
    return CGPoint(x: self.x + distance, y: self.y)
  }

  /// Shift left (decreases x)
  public func shiftedLeft(by distance: CGFloat) -> CGPoint {
    return CGPoint(x: self.x - distance, y: self.y)
  }

  /// Shift down (increases y)
  public func shiftedDown(by distance: CGFloat) -> CGPoint {
    return CGPoint(x: self.x, y: self.y + distance)
  }

  /// Shift up (decreases y)
  public func shiftedUp(by distance: CGFloat) -> CGPoint {
    let copy = self
    return CGPoint(x: copy.x, y: copy.y - distance)
  }

  /// Shift diagonally
  public func shifted(dx: CGFloat, dy: CGFloat) -> CGPoint {
    return CGPoint(x: self.x + dx, y: self.y + dy)
  }

  /// Shift by another point
  public func shifted(by point: CGPoint) -> CGPoint {
    return CGPoint(x: self.x + point.x, y: self.y + point.y)
  }
  public func shifted(by offset: CGSize) -> CGPoint {
    return CGPoint(
      x: self.x + offset.width,
      y: self.y + offset.height
    )
  }

  /// Shift by the same value in both directions
  public func shifted(by delta: CGFloat) -> CGPoint {
    return CGPoint(x: self.x + delta, y: self.y + delta)
  }

}
