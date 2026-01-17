//
//  TrackpadTouchManager.swift
//  LilyPad
//
//  Created by Dave Coleman on 3/5/2025.
//

import AppKit
import CoreTools
import VectorKit

/// Manages trackpad touches and maintains their history for velocity calculations
class TrackpadTouchManager {
  /// Tuning parameters
  var smoothingFactor: CGFloat = 0.2
  //  var coordinateSpace: CoordinateSpace = .view
  //  var coordinateSpace: CoordinateSpace = .view(CGSize.trackpadSize)

  enum CoordinateSpace {
    /// 0.0 to 1.0
    case normalized

    /// Actual pixels/points in the view
    case view(CGSize)
  }

  private var history: [AnyHashable: TouchState] = [:]

  func processCapturedTouches(
    _ nsTouches: Set<NSTouch>,
    timestamp: TimeInterval,
    in space: CoordinateSpace
      //  ) -> [TouchPoint] {
  ) -> Set<TouchPoint> {
    var results = Set<TouchPoint>()

    for touch in nsTouches {
      let id = touch.identity.hash

      /// 1. Determine Position
      let currentPos = currentPos(for: touch, in: space)

      /// 2. Calculate Velocity
      var velocity = CGVector.zero

      if let previous = history[id] {
        handlePrevState(
          previous,
          current: currentPos,
          timestamp: timestamp,
          velocity: &velocity
        )
      }

      /// 4. Store State for next frame
      if touch.phase == .ended || touch.phase == .cancelled {
        history.removeValue(forKey: id)
      } else {
        history[id] = TouchState(
          lastPosition: currentPos,
          lastTimestamp: timestamp,
          smoothedVelocity: velocity
        )
      }

      /// 5. Create the output point
      let magnitude = sqrt(velocity.dx * velocity.dx + velocity.dy * velocity.dy)

      results.insert(
        TouchPoint(
          id: id,
          position: currentPos,
          velocity: velocity,
          magnitude: magnitude,
          phase: InteractionPhase(from: touch.phase),
          isResting: touch.isResting
        ))
    }

    return results
  }

  private func handlePrevState(
    _ previousState: TouchState,
    current currentPosition: CGPoint,
    timestamp: TimeInterval,
    velocity: inout CGVector,
  ) {
    let dt = CGFloat(timestamp - previousState.lastTimestamp)

    if dt > 0 {
      velocity = CGVector.smoothed(
        previous: previousState.smoothedVelocity,
        prevPosition: previousState.lastPosition,
        currentPosition: currentPosition,
        factor: smoothingFactor,
        dt: dt
      )
    }
  }

  private func currentPos(
    for touch: NSTouch,
    in space: CoordinateSpace,
  ) -> CGPoint {
    let normalised = touch.normalizedPosition
    return switch space {
      case .normalized:
        normalised

      case .view(let size):
        CGPoint(
          x: size.width * normalised.x,
          y: size.height * (1 - normalised.y)
        )
    }
  }
}

//class TrackpadTouchManager {
//
//  public var activeTouches: Set<Int> = []
//
//  /// Dictionary to store the last known touch for each touch ID
//  private var lastTouches: [Int: TouchPoint] = [:]
//
//  /// Dictionary to store touch history for each touch ID
//  private var touchHistories: [Int: [TouchPoint]] = [:]
//
//  //  private let mappingRect: CGRect
//
//  /// Maximum number of touch points to keep in history per stroke
//  private let maxHistoryDepth: Int
//  private let velocityCalculator: VelocityCalculator
//
//  init() {
//    self.maxHistoryDepth = 8
//    self.velocityCalculator = VelocityCalculator(maxHistoryDepth: maxHistoryDepth)
//  }
//
//  func processCapturedTouches(
//    _ nsTouches: Set<NSTouch>,
//    timestamp: TimeInterval,
//  ) -> Set<TouchPoint> {
//    //  ) -> TouchEventData {
//
//    var updatedTouches = Set<TouchPoint>()
//
//    for nsTouch in nsTouches {
//      let touchId = nsTouch.identity.hash
//      let phase = nsTouch.phase
//
//      /// Handle touch lifecycle
//      switch phase {
//        case .began, .moved:
//          activeTouches.insert(touchId)
//
//        case .ended, .cancelled:
//          activeTouches.remove(touchId)
//
//          /// Clean up after processing this touch, now that it is finished
//          touchHistories.removeValue(forKey: touchId)
//          lastTouches.removeValue(forKey: touchId)
//
//        default:
//          /// This is to make sure that we don't have touches
//          /// being 'left on', resulting in the UI thinking there's
//          /// still an active touch, which often happens
//          activeTouches.remove(touchId)
//      }
//
//      /// Create raw touch point
//      let rawTouch = TouchPoint(
//        from: nsTouch,
//        touchID: touchId,
//        phase: phase,
//        timestamp: timestamp,
////        pressure: pressure,
//        deviceSize: nsTouch.deviceSize,
//        isResting: nsTouch.isResting
//      )
//
//      /// Update history
//      updateTouchHistory(touchId: touchId, touchPoint: rawTouch)
//
//      /// Compute velocity based on history
//      let history: [TouchPoint] = touchHistories[touchId] ?? []
//      let velocity = velocityCalculator.computeWeightedVelocity(from: history)
//
//      /// Create final touch with computed velocity
//      let enrichedTouch = rawTouch.withVelocity(velocity)
//      updatedTouches.insert(enrichedTouch)
//      lastTouches[touchId] = enrichedTouch
//
//    }
//
//    return updatedTouches
//    //    let eventData = TouchEventData(touches: updatedTouches, pressure: pressure)
//    //    return eventData
//  }
//
//  private func updateTouchHistory(
//    touchId: Int,
//    touchPoint: TouchPoint
//  ) {
//    var history = touchHistories[touchId] ?? []
//
//    /// Add the newest point to this touch's history
//    history.append(touchPoint)
//
//    /// Maintain rolling window
//    if history.count > maxHistoryDepth {
//      history.removeFirst()
//    }
//
//    /// Update the history entry itself
//    touchHistories[touchId] = history
//  }
//
//}
