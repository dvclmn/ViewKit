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
  public func clampedWaveValue(for wave: Wave, keyPath: WritableKeyPath<Wave, Double>) -> Double {
    
  }
}
