//
//  SubWave.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import Foundation

/// Previously handled by now-removed `WaveModulator`
@dynamicMemberLookup
public struct ConfiguredWave: WaveShaped, Sendable, Identifiable, Hashable, Codable, Equatable {
  public typealias Value = Double
  public var id: FloatWave.ID { wave.id }
  public var wave: FloatWave
  public var config: WaveConfig

  public init(_ wave: FloatWave = .example01, config: WaveConfig = .init()) {
    self.wave = wave
    self.config = config
  }
}

extension ConfiguredWave {
  
  public subscript<T>(dynamicMember keyPath: WritableKeyPath<Wave<Value>, T>) -> T {
    get { self.wave[keyPath: keyPath] }
    set { self.wave[keyPath: keyPath] = newValue }
  }
  
  public init(
    amplitude: Value,
    frequency: Value,
    phaseOffset: Value = .zero,
    waveform: Waveform = .sine,
    cycles: Value = 2,
    samples: Int = 30,
    interpolation: WaveInterpolation = .cubic(),
    noise: Value = .zero
  ) {
    let wave = FloatWave(
      amp: amplitude,
      freq: frequency,
      phase: phaseOffset,
      waveform: waveform
    )
    let config = WaveConfig(
      cycles: cycles,
      sampleCount: samples,
      interpolation: interpolation,
      noise: noise
    )
    self.wave = wave
    self.config = config
  }
}

extension ConfiguredWave {
  
  /// Evaluates the wave at a specific point in space.
  /// - Parameters:
  ///   - state: The persistent ContinuousParameter for this specific wave.
  ///   - normalisedIndex: The normalisedIndex (0...1) of the current point.
  public func sample(
    state: ContinuousParameter<Value>,
    at normalisedIndex: Value,
  ) -> Value {
    
    /// 1. Get the time-based phase from persistent state
    let temporalPhase = state.currentPhase
    
    /// 2. Add spatial phase (cycles) and static offset (wave.phase)
    let spatialPhase = normalisedIndex * Value(config.cycles)
    let staticOffset = wave.phaseRadians
    
    let totalPhase = temporalPhase + spatialPhase + staticOffset
    let wrappedPhase = totalPhase - floor(totalPhase)
    
    /// 3. Run it through the waveform math. Wrap and Sample
    let value = wave.waveform.sample(phase: wrappedPhase)
    return wave.amplitude * value
  }
  
  public static var example01: Self {
    .init(
      .example01,
      config: .init()
    )
  }

  public static var example02: Self {
    .init(
      .example02,
      config: WaveConfig(cycles: 10, sampleCount: 10)
    )
  }
}
