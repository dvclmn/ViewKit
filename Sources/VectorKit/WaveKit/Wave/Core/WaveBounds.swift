//
//  WaveBounds.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/2/2026.
//

import Foundation

/// Define sensible defaults for Wave properties, to provide ranges for UI sliders etc
public struct WaveBounds {
  public let amplitude: ClosedRange<Double>
  public let frequency: ClosedRange<Double>
  public let cycles: ClosedRange<Double>
  public let noise: ClosedRange<Double>

  public init(
    amplitude: ClosedRange<Double> = 0...600,
    frequency: ClosedRange<Double> = 0...3,
    cycles: ClosedRange<Double> = 0...30,
    noise: ClosedRange<Double> = 0...30,
  ) {
    self.amplitude = amplitude
    self.frequency = frequency
    self.cycles = cycles
    self.noise = noise
  }
}

extension WaveBounds  {
  
  subscript() -> ConfiguredWave {
    // Build a ConfiguredWave using the midpoints of the configured bounds
    let ampMid = (amplitude.lowerBound + amplitude.upperBound) / 2
    let freqMid = (frequency.lowerBound + frequency.upperBound) / 2
    let cyclesMid = (cycles.lowerBound + cycles.upperBound) / 2
    let noiseMid = (noise.lowerBound + noise.upperBound) / 2

    // Default phase at 0 and a default waveform (e.g., .sine) if available
    // If Waveform.sine is unavailable in your project, adjust accordingly.
    return ConfiguredWave(
      amplitude: ampMid,
      frequency: freqMid,
      phaseOffset: 0,
      waveform: .sine,
      cycles: cyclesMid,
      noise: noiseMid
    )
  }
  
  public func clampedWaveValue(
    for wave: Wave<Double>,
    keyPath: WritableKeyPath<Wave<Double>, Double>
  ) -> Double {
    let value = wave[keyPath: keyPath]
    let range = range(for: keyPath) ?? (Double.leastNormalMagnitude...Double.greatestFiniteMagnitude)
    return value.clamped(to: range)
  }
  
  private func range(for keyPath: WritableKeyPath<Wave<Double>, Double>) -> ClosedRange<Double>? {
    switch keyPath {
    case \Wave<Double>.amplitude:
      return amplitude
    case \Wave<Double>.frequency:
      return frequency
    default:
      return nil
    }
  }
  
}
