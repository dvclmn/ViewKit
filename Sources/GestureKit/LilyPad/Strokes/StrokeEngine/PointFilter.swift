//
//  SamplePoints.swift
//  Paperbark
//
//  Created by Dave Coleman on 30/5/2025.
//

import Foundation

public struct PointFilter {

//  public static func generateCulledPoints(
//    previousPoint: CGPoint?,
//    _ rawPoints: [MappedTouchPoint],
//    config: StrokeConfiguration
//  ) -> [MappedTouchPoint] {
//
//    var culled: [MappedTouchPoint] = []
//    for point in rawPoints
//    where shouldAddPoint(
//      from: previousPoint,
//      to: point,
//      config: config
//    ) {
//      culled.append(point)
//    }
//    
////    print("Culling results: Started with \(rawPoints.count) raw points, culled to \(culled.count)")
//    
//    return culled
//  }

  /// Determines whether to add a new point to the stroke
  /// - Parameters:
  ///   - last: The previous point in the stroke
  ///   - current: The new touch event
  /// - Returns: true if the point should be added to the stroke
  public static func shouldAddPoint(
    from last: CGPoint?,
    to current: VelocityPoint,
//    to current: MappedTouchPoint,
    config: StrokeConfiguration
  ) -> Bool {

    /// This way we definitely add the first point
    guard let last else {
      print("Point was added without any culling.")
      return true
    }

    let slowMovementThreshold = config.slowMovementThreshold
    let minDistance: CGFloat = config.minDistanceBeforeAddingPoint

    let distance = current.position.distance(to: last)
//    let distance = hypot(
//      current.position.x - last.x,
//      current.position.y - last.y
//    )
    
    /// Minimum == the lower limit, the smallest distance that is allowed
//    print("Minimum distance between points: \(minDistance). Actual distance travelled is \(distance)")
    
    /// Always add point if we exceed distance threshold
    guard distance < minDistance else { return true }

    /// Use the touch event's pre-calculated velocity
    let speed: CGFloat = current.velocity.speed

    /// Add point if moving slowly
    return speed < slowMovementThreshold
  }

}
