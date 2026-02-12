//
//  SubWave.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import Foundation

@dynamicMemberLookup
public struct ConfiguredWave: Sendable, Identifiable, Hashable, Codable, Equatable {
  public var id: FloatWave.ID { wave.id }
  public var wave: FloatWave
  public var config: WaveConfig

  public init(_ wave: FloatWave = .example01, config: WaveConfig = .init()) {
    self.wave = wave
    self.config = config
  }
}

extension ConfiguredWave {

  public subscript<T>(dynamicMember keyPath: WritableKeyPath<Wave<Double>, T>) -> T {
    get { self.wave[keyPath: keyPath] }
    set { self.wave[keyPath: keyPath] = newValue }
  }

  public init(
    amplitude: Double,
    frequency: Double,
    phaseOffset: Double = .zero,
    waveform: Waveform = .sine,
    cycles: Double = 2,
    noise: Double = .zero
  ) {
    let wave = FloatWave(
      amp: amplitude,
      freq: frequency,
      phase: phaseOffset,
      waveform: waveform
    )
    let config = WaveConfig(
      cycles: cycles,
      noise: noise
    )
    self.wave = wave
    self.config = config
  }

  /// Returns the corresponding bounds range for a Wave property on this configured wave.
  /// Usage: `let r = configuredWave[bounds: someBounds, keyPath: \Wave<Double>.amplitude]`
  public subscript(bounds bounds: WaveBounds, keyPath keyPath: WritableKeyPath<Wave<Double>, Double>) -> ClosedRange<Double> {
    switch keyPath {
    case \Wave<Double>.amplitude:
      return bounds.amplitude
    case \Wave<Double>.frequency:
      return bounds.frequency
    default:
      // If you add more Double properties to Wave (e.g., exposing phaseRadians), map them here.
      // Fallback to a very wide range to avoid crashing.
      return (Double.leastNormalMagnitude...Double.greatestFiniteMagnitude)
    }
  }

  /// Returns the corresponding bounds range for a Config property (cycles, noise) on this configured wave.
  /// Usage: `let r = configuredWave[bounds: someBounds, config: \WaveConfig.cycles]`
  public subscript(bounds bounds: WaveBounds, config keyPath: WritableKeyPath<WaveConfig, Double>) -> ClosedRange<Double> {
    switch keyPath {
    case \WaveConfig.cycles:
      return bounds.cycles
    case \WaveConfig.noise:
      return bounds.noise
    default:
      return (Double.leastNormalMagnitude...Double.greatestFiniteMagnitude)
    }
  }
}

extension ConfiguredWave {

  /// Evaluates the wave at a specific point in space.
  /// - Parameters:
  ///   - state: The persistent ContinuousParameter for this specific wave.
  ///   - normalisedIndex: The normalisedIndex (0...1) of the current point.
  #warning("Put this back into use. Somewhere")
//  public func sample(
//    state: ContinuousParameter<Double>,
//    at normalisedIndex: Double,
//  ) -> Double {
//
//    /// 1. Get the time-based phase from persistent state
//    let temporalPhase = state.currentPhase
//
//    /// 2. Add spatial phase (cycles) and static offset (wave.phase)
//    let spatialPhase = normalisedIndex * Double(config.cycles)
//    let staticOffset = wave.phaseRadians
//
//    let totalPhase = temporalPhase + spatialPhase + staticOffset
//    let wrappedPhase = totalPhase - floor(totalPhase)
//
//    /// 3. Run it through the waveform math. Wrap and Sample
//    let value = wave.waveform.sample(phase: wrappedPhase)
//    return wave.amplitude * value
//  }

  public static var example01: Self {
    .init(
      .example01,
      config: .init()
    )
  }

  //  public static var example02: Self {
  //    .init(
  //      .example02,
  //      config: WaveConfig(cycles: 10, sampleCount: 10)
  //    )
  //  }
}

