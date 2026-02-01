//
//  Oscillaltor.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/2/2026.
//

public struct Oscillator {
  var freq: Smoothed
  var amp: Smoothed
  var phaseOffset: Smoothed
  var phase: ContinuousParameter
  
  mutating func tick(now: TimeInterval, dt: Float, smoothing: Float) -> Float {
    // 1) Smooth the inputs
    freq.update(dt: dt, smoothing: smoothing)
    amp.update(dt: dt, smoothing: smoothing)
    phaseOffset.update(dt: dt, smoothing: smoothing)
    
    // 2) Advance the phase using the (smoothed) frequency
    phase.update(at: now, frequency: Float(freq.displayed))
    
    // 3) Sample waveform
    let θ = 2 * .pi * Float(phase.currentPhase) + phaseOffset.displayed
    return amp.displayed * sin(θ)
  }
}
