//
//  Oscillaltor.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/2/2026.
//

import Foundation

/// A reusable oscillator you can hold onto and query with a time value.
public struct Oscillator {
  public var amplitude: Double
  public var frequency: Double
  public var phase: Double
  
  /// Oscillation occurs around this baseline value
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
    oscillate(
      time: time,
      base: base,
      amplitude: amplitude,
      frequency: frequency,
      phase: phase
    )
  }

  @inlinable
  public func valueCGFloat(at time: TimeInterval) -> CGFloat {
    CGFloat(value(at: time))
  }
}

public struct OscillatorSmoothed {
  public var waveform: Waveform
  var freq: SmoothedFloat
  var amp: SmoothedFloat
  var phaseOffset: SmoothedFloat
  var phase: ContinuousFloat

  //  public init(
  //    waveform: Waveform,
  //    freq: Smoothed<T>,
  //    amp: Smoothed<T>,
  //    phaseOffset: Smoothed<T>,
  //    phase: ContinuousParameter<T>
  //  ) {
  //    self.waveform = waveform
  //    self.freq = freq
  //    self.amp = amp
  //    self.phaseOffset = phaseOffset
  //    self.phase = phase
  //  }

  mutating func tick(now: TimeInterval, dt: Float, smoothing: Float) -> Float {
    /// 1) Smooth the inputs
    freq.update(dt: dt, smoothing: smoothing)
    amp.update(dt: dt, smoothing: smoothing)
    phaseOffset.update(dt: dt, smoothing: smoothing)

    /// 2) Advance the phase using the (smoothed) frequency
    phase.update(at: now, frequency: freq.displayed)

    /// 3) Sample waveform using WaveSampler
    // Convert phase to a scalar in [0, 1) expected by the sampler, then apply phase offset in turns
    let basePhase: Float = phase.currentPhase
    let shiftedPhase = basePhase + phaseOffset.displayed
    let sample = Sampler.value(for: waveform, at: shiftedPhase)
    return amp.displayed * sample
  }

}
