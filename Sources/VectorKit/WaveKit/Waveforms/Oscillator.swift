//
//  Oscillaltor.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/2/2026.
//

import Foundation

public struct Oscillator<T: BinaryFloatingPoint> {
  var freq: Smoothed<T>
  var amp: Smoothed<T>
  var phaseOffset: Smoothed<T>
  var phase: ContinuousParameter
  
  mutating func tick(now: TimeInterval, dt: T, smoothing: T) -> T {
    /// 1) Smooth the inputs
    freq.update(dt: dt, smoothing: smoothing)
    amp.update(dt: dt, smoothing: smoothing)
    phaseOffset.update(dt: dt, smoothing: smoothing)
    
    /// 2) Advance the phase using the (smoothed) frequency
    phase.update(at: now, frequency: freq.displayed)
    
    /// 3) Sample waveform
    WaveSampler.value(for: self, at: phase)
//    let θ = 2 * .pi * phase.currentPhase + phaseOffset.displayed
//    return amp.displayed * sin(θ)
  }
}
