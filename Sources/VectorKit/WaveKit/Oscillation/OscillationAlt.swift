//
//  OscillationAlt.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/2/2026.
//

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
  base: Double,
  amplitude: Double,
  frequency: Double = 1.0,
  phase: Double = 0.0
) -> Double {
  // y(t) = base + amplitude * sin(2π f t + phase)
  let omega = 2.0 * .pi * frequency
  return base + amplitude * sin(omega * time + phase)
}

@inlinable
public func oscillate(
  time: TimeInterval,
  base: Float,
  amplitude: Float,
  frequency: Float = 1.0,
  phase: Float = 0.0
) -> Float {
  let omega = 2.0 * Float.pi * frequency
  return base + amplitude * sin(omega * Float(time) + phase)
}

@inlinable
public func oscillate(
  time: TimeInterval,
  base: CGFloat,
  amplitude: CGFloat,
  frequency: CGFloat = 1.0,
  phase: CGFloat = 0.0
) -> CGFloat {
  let omega = 2.0 * .pi * frequency
  return base + amplitude * sin(omega * CGFloat(time) + phase)
}

/// Oscillates around a center value within a +/- range.
@inlinable
public func oscillateAround(
  center: Double,
  range: Double,
  time: TimeInterval,
  frequency: Double = 1.0,
  phase: Double = 0.0
) -> Double {
  oscillate(time: time, base: center, amplitude: range, frequency: frequency, phase: phase)
}

@inlinable
public func oscillateAround(
  center: CGFloat,
  range: CGFloat,
  time: TimeInterval,
  frequency: CGFloat = 1.0,
  phase: CGFloat = 0.0
) -> CGFloat {
  oscillate(time: time, base: center, amplitude: range, frequency: frequency, phase: phase)
}

// MARK: - Spatial helpers

public enum SpatialAxis {
  case x, y, width, height
}

/// Returns a new CGPoint whose selected axis is oscillated around the provided base value.
@inlinable
public func oscillating(
  point: CGPoint,
  axis: SpatialAxis,
  time: TimeInterval,
  amplitude: CGFloat,
  frequency: CGFloat = 1.0,
  phase: CGFloat = 0.0,
  baseOverride: CGFloat? = nil
) -> CGPoint {
  var p = point
  switch axis {
    case .x:
      let base = baseOverride ?? point.x
      p.x = oscillate(time: time, base: base, amplitude: amplitude, frequency: frequency, phase: phase)
    case .y:
      let base = baseOverride ?? point.y
      p.y = oscillate(time: time, base: base, amplitude: amplitude, frequency: frequency, phase: phase)
    case .width, .height:
      // Not applicable to CGPoint, leave unchanged
      break
  }
  return p
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

/// A reusable oscillator you can hold onto and query with a time value.
public struct Oscillator {
  public var amplitude: Double
  public var frequency: Double
  public var phase: Double
  public var base: Double
  
  public init(
    base: Double = 0,
    amplitude: Double = 1,
    frequency: Double = 1,
    phase: Double = 0
  ) {
    self.base = base
    self.amplitude = amplitude
    self.frequency = frequency
    self.phase = phase
  }
  
  @inlinable
  public func value(at time: TimeInterval) -> Double {
    oscillate(time: time, base: base, amplitude: amplitude, frequency: frequency, phase: phase)
  }
  
  @inlinable
  public func valueCGFloat(at time: TimeInterval) -> CGFloat {
    CGFloat(value(at: time))
  }
}
