//
//  DragHandler.swift
//  BaseComponents
//
//  Created by Dave Coleman on 8/3/2025.
//




import SwiftUI

//@Observable
struct BouncyHandler {
//final class BouncyHandler {
  /// This was to be paired with a `TImelineView`,
  /// to drive time-based oscillation values.
  /// Switched off for now.
  //  var time: Date = .now
  var tension: CGFloat

  /// A global flag, for whether the bouncy interaction
  /// as a whole is enabled.
  var isEnabled: Bool
  var inputMethod: DragMethod = .idle
  var dragOffset: CGSize = .zero
  //  var dragOffset: CGSize = .zero

  
  
  /// Is a two-finger pan gesture being used to
  /// manipulate the View
  //  var isPanning: Bool = false
  var scaleHandler = BouncyScale()
  /// Note: previously had option for passing view size
  /// in externally via init. But for simplicity, have decided
  /// to keep the derivation internal, and wear any potential
  /// performance impact (which would be minimal anyway).
  ///
  /// This is populated via `viewSize` modifier in the view
  var containerSize: CGSize = .zero

  /// This is supplied in cases where the container view
  /// is quite small, and the effect would otherwise be too subtle.
  static let minDragThreshold: CGFloat = 200

  init(
    tension: CGFloat,
    isEnabled: Bool
  ) {
    self.tension = tension
    self.isEnabled = isEnabled
  }
}

extension BouncyHandler {

  mutating func reset() {
    dragOffset = .zero
    inputMethod = .idle
  }

  func isInputMethodEnabled(_ input: DragMethod) -> Bool {
    guard isEnabled,
      inputMethod == .idle
    else { return false }
    return true
  }

  var dragArea: CGSize {
    return containerSize.clampBothDimensions(toMin: Self.minDragThreshold)
  }

//  func dragTension() -> CGSize {
//
//  }

  func handleScale() -> CGFloat {
    /// Calculate distance using Pythagorean theorem
    let distance = sqrt(pow(dragOffset.width, 2) + pow(dragOffset.height, 2))

    /// If within dead zone, return 1 (no effect)
    if distance <= scaleHandler.deadZone {
      return 1.0
    }

    /// Normalize the distance to 0-1 range, accounting for dead zone
    let adjustedDistance = (distance - scaleHandler.deadZone) / 1000
    let normalised = min(max(adjustedDistance, 0), 1)
    
    let curved = scaleHandler.curve.value(at: normalised, min: 0, max: 1)
  
    /// Calculate final scale (1.0 to 1.0 - maxEffect)
    return 1.0 + (curved * scaleHandler.maxEffectThreshold)
  }
//
//  var scaleAmount: Double {
//
//    /// This is the Pythagorean theorem. It's calculating the direct distance from the start point
//    /// Squares the `x` distance
//    let powWidth = pow(dragOffset.width, 2)
//
//    ///  squares the `y` distance
//    let powHeight = pow(dragOffset.height, 2)
//
//    /// `sqrt()` of their sum gives us the straight-line distance from the origin
//    /// This is known as the "magnitude" or "length" of the drag vector
//    let distanceFromOrigin = sqrt(powWidth + powHeight)
//
//    let result: Double = 1.0 + (distanceFromOrigin * scaleHandler.maxEffectThreshold)
//
//    return result
//  }

  /// Convert Date to seconds for easier math
//  var timeInterval: TimeInterval {
//    time.timeIntervalSinceReferenceDate
//  }
//
//  /// 1. Simple sine wave oscillation
//  var basicOscillation: Double {
//    /// Oscillates between -1 and 1
//    sin(timeInterval)
//  }
//
//  /// 2. Controlled oscillation with custom amplitude and frequency
//  var controlledOscillation: Double {
//    let amplitude: Double = 20  // Maximum displacement
//    let frequency: Double = 2  // Cycles per second
//    return amplitude * sin(timeInterval * frequency * .pi * 2)
//  }
//
//  /// 3. Combined waves
//  var complexOscillation: Double {
//    let fast = 15 * sin(timeInterval * 3)
//    let slow = 5 * sin(timeInterval * 0.5)
//    return fast + slow
//  }
//
//  /// 4. Circular motion
//  var circularMotion: CGSize {
//    let radius: Double = 20
//    let frequency: Double = 1
//    return CGSize(
//      width: radius * cos(timeInterval * frequency * .pi * 2),
//      height: radius * sin(timeInterval * frequency * .pi * 2)
//    )
//  }
//
//  var wigglingOffset: CGSize {
//    dragOffset + complexOscillation
//    //    let stretch = calculateCurrentStretchRatio
//    //
//    //    dragOffset + calculateShakeOffset(
//    //      intensity: dragOffset.length * 10,
//    //      phase: .pi * 2 * timeInterval
//    //    )
//  }
//
//  /// Helper function to calculate current stretch ratio
//  func calculateCurrentStretchRatio(
//    in size: CGSize
//  ) -> Double {
//    let viewDiagonal = sqrt(pow(size.width, 2) + pow(size.height, 2))
//    let dragDistance = sqrt(pow(dragOffset.width, 2) + pow(dragOffset.height, 2))
//    return dragDistance / (viewDiagonal / 2)
//  }
//
//  func calculateShakeOffset(
//    intensity: Double,
//    phase: Double
//  ) -> CGSize {
//    let xOffset = sin(phase) * intensity
//    /// Different frequency for y
//    let yOffset = cos(phase * 1.5) * intensity
//    return CGSize(width: xOffset, height: yOffset)
//  }

}
