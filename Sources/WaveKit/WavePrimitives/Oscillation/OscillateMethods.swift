//
//  OscillationAlt.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/2/2026.
//

import Foundation
//import InteractionKit
import CoreTools
//import ViewTools
//import BaseTools

/// IMPORTANT:
/// Moving to use of ``WaveSampler``:
/// Oscillator and oscillate(...)
/// • Keep oscillate(time: base: amplitude: frequency: phase:) as-is (it’s a standard, easy-to-read formula).
/// • If you want to route through Wave​Sampler for consistency:
/// - Convert from radians to turns: phase​Turns = frequency * time + (phase / (2π))
/// - Then sample(.sine, phase: phase​Turns, domain: .turns, sine​Mode: .auto), and scale by amplitude and add base.

/// Returns an oscillating value using a sine wave.
/// - Parameters:
///   - time: Time in seconds (monotonic). You can pass `AnimationTimeline`'s `time` here.
///   - base: The baseline value around which the oscillation occurs.
///   - amplitude: Peak deviation from the baseline.
///   - frequency: Oscillations per second (Hz).
///   - phase: Phase offset in radians. Use 0 for no offset.
/// - Returns: The oscillated value at the given time.
@inlinable
public func oscillate(
  time: Double,
  //  time: TimeInterval,
  base: Double,
  amplitude: Double,
  frequency: Double = 1.0,
  phase: Double = 0.0,
) -> Double {
  /// `y(t) = base + amplitude * sin(2π f t + phase)`
  let result = base + amplitude * sin(frequency.omega * time + phase)
  //  DebugString("Oscillation", indented: true) {
  //    Labeled("Time", value: time)
  //    //    Labeled("Float Time", value: Float(time))
  //    Labeled("Base Value", value: base)
  //    Labeled("Amp", value: amplitude)
  //    Labeled("Freq", value: frequency)
  //    Labeled("Omega", value: frequency.omega)
  //    Labeled("Phase", value: phase)
  //    Divider()
  //    Labeled("Result", value: result)
  //    Divider()
  //  }
  return result
}

/// Oscillates around a center value within a +/- range.
@inlinable
public func oscillateAround(
  center: Double,
  range: Double,
  time: Double,
  //  time: TimeInterval,
  frequency: Double = 1.0,
  phase: Double = 0.0,
) -> Double {
  oscillate(time: time, base: center, amplitude: range, frequency: frequency, phase: phase)
}

// MARK: - Spatial helpers

//public enum SpatialAxis {
//  case x, y, width, height
//}

/// Returns a new CGPoint whose selected axis is oscillated around the provided base value.
@inlinable
public func oscillating(
  value: CGPoint,
  axis: GeometryAxis,
  mapping: AxisMapping = .default,
  time: Double,
  //  time: TimeInterval,
  amplitude: Double,
  frequency: Double = 1.0,
  phase: Double = 0.0,
  baseOverride: Double? = nil,
) -> CGPoint {
  value.adjust(axis, mapping: mapping) {
    oscillate(
      time: time,
      base: baseOverride ?? $0,
      amplitude: amplitude,
      frequency: frequency,
      phase: phase,
    ).toCGFloat
  }
  //  p.adjust(axis, using: ., mapping: mapping)
  //  let oscillated = oscillate(
  //    time: time,
  //    base: base,
  //    amplitude: amplitude,
  //    frequency: frequency,
  //    phase: phase
  //  )
  //  return oscillated
  //  switch axis {
  //    case .x:
  //      let base = baseOverride ?? point.x
  //      p.x = oscillate(time: time, base: base, amplitude: amplitude, frequency: frequency, phase: phase)
  //    case .y:
  //      let base = baseOverride ?? point.y
  //      p.y = oscillate(time: time, base: base, amplitude: amplitude, frequency: frequency, phase: phase)
  //    case .width, .height:
  //      // Not applicable to CGPoint, leave unchanged
  //      break
  //  }
  //  return p
}

/// Returns a new CGSize whose selected axis is oscillated around the provided base value.
@inlinable
public func oscillating(
  value: CGSize,
  axis: GeometryAxis,
  mapping: AxisMapping = .default,
  time: Double,
  //  time: TimeInterval,
  amplitude: Double,
  frequency: Double = 1.0,
  phase: Double = 0.0,
  baseOverride: Double? = nil,
) -> CGSize {
  value.adjust(axis, mapping: mapping) {
    oscillate(
      time: time,
      base: baseOverride ?? $0,
      amplitude: amplitude,
      frequency: frequency,
      phase: phase,
    ).toCGFloat
  }
}

// MARK: - Oscillator type

@available(*, deprecated, message: "Prefer other `oscillate` methods, this one's old")
public func oscillate(
  in range: ClosedRange<Double> = -50...50,
  frequency: Double = 1.0,
  noise: Double = 0.0,  // 0.0 = predictable, 1.0 = chaotic
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
