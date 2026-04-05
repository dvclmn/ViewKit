//
//  MovementVector.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 4/2/2026.
//

import Foundation

// Separate movement calculation logic
struct MovementVector {
  
  static func randomWanderAlt(
    in range: ClosedRange<Double> = -50...50,
    frequency: Double = 1.0,
    chaos: Double = 0.3
  ) -> CGPoint {
    fatalError("Shut up")
    // Use different frequency offsets for x and y to create more organic movement
//    let x = oscillate(in: range, frequency: frequency * 1.0, noise: chaos)
//    let y = oscillate(in: range, frequency: frequency * 1.3, noise: chaos)
//    return CGPoint(x: x, y: y)
  }
  
  static func randomWander(
    in range: ClosedRange<Double> = -50...50,
    frequency: Double = 1.0,
    chaos: Double = 0.3
  ) -> CGPoint {
    let now = Date().timeIntervalSinceReferenceDate
    
    // Create different oscillations for more organic movement
    func wave(_ frequency: Double, _ amplitude: Double) -> Double {
      sin(now * .pi * 2 * frequency) * amplitude
    }
    
    // X coordinate combines multiple waves
    let x =
    wave(frequency, 0.6) + wave(frequency * 1.3, 0.25) + wave(frequency * 2.7, 0.15) + Double.random(
      in: -1...1) * chaos
    
    // Y coordinate uses different frequencies for more natural movement
    let y =
    wave(frequency * 1.1, 0.6) + wave(frequency * 1.7, 0.25) + wave(frequency * 2.3, 0.15) + Double.random(
      in: -1...1) * chaos
    
    // Scale to desired range
    let middle = (range.upperBound + range.lowerBound) / 2
    let amplitude = (range.upperBound - range.lowerBound) / 2
    
    return CGPoint(
      x: middle + x * amplitude,
      y: middle + y * amplitude
    )
  }
}
