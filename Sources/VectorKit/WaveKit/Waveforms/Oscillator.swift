//
//  Oscillaltor.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/2/2026.
//

import Foundation

public struct Oscillator<T: WaveFloat> {
  public var waveform: Waveform
  var freq: Smoothed<T>
  var amp: Smoothed<T>
  var phaseOffset: Smoothed<T>
  var phase: ContinuousParameter<T>

  mutating func tick(now: TimeInterval, dt: T, smoothing: T) -> T {
    /// 1) Smooth the inputs
    freq.update(dt: dt, smoothing: smoothing)
    amp.update(dt: dt, smoothing: smoothing)
    phaseOffset.update(dt: dt, smoothing: smoothing)

    /// 2) Advance the phase using the (smoothed) frequency
    phase.update(at: now, frequency: freq.displayed)

    /// 3) Sample waveform using WaveSampler
    // Convert phase to a scalar in [0, 1) expected by the sampler, then apply phase offset in turns
    let basePhase: T = phase.currentPhase
    let shiftedPhase = basePhase + phaseOffset.displayed
    let sample = WaveSampler<T>.value(for: waveform, at: shiftedPhase)
    return amp.displayed * sample
  }

  public init(
    waveform: Waveform,
    freq: Smoothed<T>,
    amp: Smoothed<T>,
    phaseOffset: Smoothed<T>,
    phase: ContinuousParameter<T>
  ) {
    self.waveform = waveform
    self.freq = freq
    self.amp = amp
    self.phaseOffset = phaseOffset
    self.phase = phase
  }
}
