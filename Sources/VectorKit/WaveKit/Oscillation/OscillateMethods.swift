//
//  OscillationAlt.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/2/2026.
//

import CoreTools
import Foundation

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
  time: TimeInterval,
  base: Float,
  amplitude: Float,
  frequency: Float = 1.0,
  phase: Float = 0.0
) -> Float {
  /// `y(t) = base + amplitude * sin(2π f t + phase)`
  return base + amplitude * sin(frequency.omega * Float(time) + phase)
}

/// Oscillates around a center value within a +/- range.
@inlinable
public func oscillateAround(
  center: Float,
  range: Float,
  time: TimeInterval,
  frequency: Float = 1.0,
  phase: Float = 0.0
) -> Float {
  oscillate(time: time, base: center, amplitude: range, frequency: frequency, phase: phase)
}

// MARK: - Spatial helpers

//public enum SpatialAxis {
//  case x, y, width, height
//}

/// Returns a new CGPoint whose selected axis is oscillated around the provided base value.
@inlinable
public func oscillating<T: AdjustableByAxis>(
  value: T,
  axis: GridAxis,
  mapping: AxisMapping = .default,
  //  axis: SpatialAxis,
  time: TimeInterval,
  amplitude: Float,
  frequency: Float = 1.0,
  phase: Float = 0.0,
  baseOverride: Float? = nil
) -> some AdjustableByAxis where T.Component: BinaryFloatingPoint {
  value.adjust(axis, mapping: mapping) {
    oscillate(
      time: time,
      base: baseOverride ?? Float($0),
      amplitude: amplitude,
      frequency: frequency,
      phase: phase
    )
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
  size: CGSize,
  axis: SpatialAxis,
  time: TimeInterval,
  amplitude: CGFloat,
  frequency: CGFloat = 1.0,
  phase: CGFloat = 0.0,
  baseOverride: CGFloat? = nil
) -> CGSize {
  var s = size
  switch axis {
    case .width:
      let base = baseOverride ?? size.width
      s.width = oscillate(time: time, base: base, amplitude: amplitude, frequency: frequency, phase: phase)
    case .height:
      let base = baseOverride ?? size.height
      s.height = oscillate(time: time, base: base, amplitude: amplitude, frequency: frequency, phase: phase)
    case .x, .y:
      // Not applicable to CGSize, leave unchanged
      break
  }
  return s
}

// MARK: - Oscillator type

@available(*, deprecated, message: "Prefer other `oscillate` methods, this one's old")
public func oscillate(
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
