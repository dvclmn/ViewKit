//
//  PeriodicMaths.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 29/1/2026.
//

import Foundation

extension BinaryFloatingPoint {
  static func oscillate(
    in range: ClosedRange<Double> = -50...50,
    frequency: Double = 1.0,
    noise: Double = 0.0  // 0.0 = predictable, 1.0 = chaotic
  ) -> Double {
    let now = Date().timeIntervalSinceReferenceDate
    
    // Primary wave
    let primary = sin(now * .pi * 2 * frequency)
    
    // Secondary waves with different frequencies
    let secondary = sin(now * .pi * 1.3 * frequency)
    let tertiary = sin(now * .pi * 2.7 * frequency)
    
    // Combine waves with some randomness
    let noise = Double.random(in: -1...1) * noise
    let combined = primary * 0.6 + secondary * 0.25 + tertiary * 0.15 + noise
    
    // Scale to range
    let middle = (range.upperBound + range.lowerBound) / 2
    let amplitude = (range.upperBound - range.lowerBound) / 2
    return middle + combined * amplitude
  }
}
