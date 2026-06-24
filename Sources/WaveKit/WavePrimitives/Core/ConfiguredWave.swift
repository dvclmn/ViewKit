//
//  SubWave.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import Foundation

@dynamicMemberLookup
public struct ConfiguredWave: Sendable, Identifiable, Hashable, Codable, Equatable {
  public var id: Wave<Double>.ID { wave.id }
  public var wave: Wave<Double>
  public var config: WaveConfig

  public init(
    _ wave: Wave<Double>,
    config: WaveConfig = .init()
  ) {
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
    waveform: Waveform = .sine(),
    cycles: Double = 2,
    noise: Double = .zero
  ) {
    let wave = FloatWave(
      amp: amplitude,
      freq: frequency,
      phaseTurns: phaseOffset,
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

  /// Evaluates this wave at a normalised spatial position and elapsed time.
  ///
  /// Every phase component is expressed in turns:
  ///
  /// ```
  /// frequency * elapsed + cycles * index + phase offset
  /// ```
  ///
  /// ``WaveSampler`` owns phase wrapping and waveform evaluation. Amplitude is
  /// applied only after the unit waveform has been sampled.
  @inlinable
  public func sample(
    at index: Double,
    elapsed: TimeInterval
  ) -> Double {
    let phaseTurns =
      wave.frequency * elapsed
      + config.cycles * index
      + wave.unitPhase

    return wave.amplitude
      * WaveSampler<Double>.sample(wave.waveform, phase: phaseTurns)
  }

  /// Evaluates this wave at several normalised spatial positions.
  @inlinable
  public func samples(
    at indices: [Double],
    elapsed: TimeInterval
  ) -> [Double] {
    indices.map { sample(at: $0, elapsed: elapsed) }
  }

  /// Returns the temporal phase in radians for compatibility with the former
  /// renderer-owned evaluation path.
  @available(
    *,
    deprecated,
    message: "Use sample(at:elapsed:) so phase units remain internal to ConfiguredWave."
  )
  public func timePhase(from elapsed: TimeInterval) -> Double {
    .twoPi * wave.frequency * elapsed
  }

  /// Samples an already-combined phase expressed in turns. The index and sine
  /// mode parameters are retained solely for source compatibility.
  @inlinable
  @available(
    *,
    deprecated,
    message: "Use sample(at:elapsed:); combinedPhase is expressed in turns."
  )
  public func sampleAlt(
    at index: Double,
    combinedPhase: Double,
    //    time: TimeInterval,
    sineMode: SineMode = .table
  ) -> Double {
    let y = WaveSampler<Double>.sample(wave.waveform, phase: combinedPhase)
    return wave.amplitude * y
  }

  /// Compatibility spelling for ``sample(at:elapsed:)``.
  @inlinable
  @available(*, deprecated, message: "Use sample(at:elapsed:).")
  public func sampleTurns(
    at index: Double,
    time: TimeInterval,
    sineMode: SineMode = .table
  ) -> Double {
    sample(at: index, elapsed: time)
  }

  @available(*, deprecated, message: "Use samples(at:elapsed:).")
  public func samples(
    indices: [Double],  // Normalised, across a slice of a view
    time: TimeInterval
  ) -> [Double] {
    samples(at: indices, elapsed: time)
  }
}
