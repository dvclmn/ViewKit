//
//  Velocity+Exts.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/1/2026.
//



//extension TouchPoint {
//  //extension TrackpadTouch {
//  
//  public var direction: CGFloat {
//    return atan2(velocity.dy, velocity.dx)
//  }
//  
//  /// Whether this touch has meaningful pressure data
//  public var hasPressure: Bool {
//    return pressure > 0
//  }
//  
//  /// Pressure clamped between 0 and 1 for drawing operations
//  public var clampedPressure: CGFloat {
//    return min(max(pressure, 0), 1)
//  }
//}
//
//extension Array where Element == TouchPoint {
//  public var cgPoints: [CGPoint] {
//    return self.map(\.position)
//  }
//}
//
//extension Set where Element == TouchPoint {
//  public var cgPoints: [CGPoint] {
//    return self.map(\.position)
//  }
//}
