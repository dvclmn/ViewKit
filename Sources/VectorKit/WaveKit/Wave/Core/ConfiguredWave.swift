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
}

extension ConfiguredWave {

  // Radians path
  @inlinable
  public func sample(at index: Double, time: TimeInterval, sineMode: SineMode = .auto) -> Double {
    let timePhase = .twoPi * wave.frequency * time
    let staticPhase = wave.phaseRadians
    let spatial = Double(config.cycles)

    let angle = timePhase + (spatial * .twoPi * index) + staticPhase
    let y = WaveSampler<Double>.value(for: wave.waveform, atRadians: angle)
    return wave.amplitude * y
  }

  // Turns path (optional, if you sometimes prefer a turns domain)
  @inlinable
  public func sampleTurns(at index: Double, time: TimeInterval, sineMode: SineMode = .auto) -> Double {
    let temporalTurns = (wave.frequency * time)  // f*t cycles
    let staticTurns = wave.phaseRadians / .twoPi
    let spatialTurns = Double(config.cycles) * index
    let total = temporalTurns + spatialTurns + staticTurns
    let wrapped = total - floor(total)
    let y = WaveSampler<Double>.value(for: wave.waveform, atTurns: wrapped)
    return wave.amplitude * y
  }

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

}
