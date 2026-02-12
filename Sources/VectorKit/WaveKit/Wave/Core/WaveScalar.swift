//
//  WaveScalar.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 12/2/2026.
//

import Foundation

public enum WaveScalar: String, CaseIterable, Codable, Hashable, Sendable {
  case amplitude
  case frequency
  case cycles
  case noise
}

extension WaveScalar {
  public var boundsKeyPath: KeyPath<WaveBounds, ClosedRange<Double>> {
    switch self {
      case .amplitude: \.amplitude
      case .frequency: \.frequency
      case .cycles: \.cycles
      case .noise: \.noise
    }
  }

  public func get(from wave: ConfiguredWave) -> Double {
    switch self {
      case .amplitude: wave.wave.amplitude
      case .frequency: wave.wave.frequency
      case .cycles: wave.config.cycles
      case .noise: wave.config.noise
    }
  }

  public func set(_ newValue: Double, on wave: inout ConfiguredWave) {
    switch self {
      case .amplitude: wave.wave.amplitude = newValue
      case .frequency: wave.wave.frequency = newValue
      case .cycles: wave.config.cycles = newValue
      case .noise: wave.config.noise = newValue
    }
  }
}

extension WaveBounds {
  public subscript(_ scalar: WaveScalar) -> ClosedRange<Double> {
    self[keyPath: scalar.boundsKeyPath]
  }
}
