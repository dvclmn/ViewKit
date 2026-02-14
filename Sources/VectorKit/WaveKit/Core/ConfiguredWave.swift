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

  public func timePhase(from elapsed: TimeInterval) -> Double {
    .twoPi * wave.frequency * elapsed
  }

  /// Radians path
  //  @inlinable
  //  public func sample(
  //    at index: Double,
  //    time: TimeInterval,
  //    sineMode: SineMode = .auto
  //  ) -> Double {
  //    let timePhase = .twoPi * wave.frequency * time
  //    let staticPhase = wave.phaseRadians
  //    let spatial = Double(config.cycles)
  //
  //    let angle = timePhase + (spatial * .twoPi * index) + staticPhase
  //    let y = WaveSampler<Double>.value(for: wave.waveform, atRadians: angle)
  //    return wave.amplitude * y
  //  }

  @inlinable
  public func sampleAlt(
    at index: Double,
    combinedPhase: Double,
//    time: TimeInterval,
    sineMode: SineMode = .table
  ) -> Double {
//    let temporalTurns = (wave.frequency * time * .twoPi)  // f*t cycles
//    let staticTurns = wave.phaseRadians
//    let spatialTurns = Double(config.cycles) * index * .twoPi
//    let total = temporalTurns + spatialTurns + staticTurns
    //    let wrapped = total - floor(total)
    let y = WaveSampler<Double>.
//    let y = WaveSampler<Double>.value(for: wave.waveform, atTurns: total)
    return wave.amplitude * y
  }
  
  /// Turns path
  @inlinable
  public func sampleTurns(
    at index: Double,
    time: TimeInterval,
    sineMode: SineMode = .table
  ) -> Double {
    let temporalTurns = (wave.frequency * time * .twoPi)  // f*t cycles
    let staticTurns = wave.phaseRadians
    let spatialTurns = Double(config.cycles) * index * .twoPi
    let total = temporalTurns + spatialTurns + staticTurns
    //    let wrapped = total - floor(total)
    let y = WaveSampler<Double>.value(for: wave.waveform, atTurns: total)
    return wave.amplitude * y
  }

  public func samples(
    indices: [Double],  // Normalised, across a slice of a view
    time: TimeInterval
  ) -> [Double] {
    var ys: [Double] = []
    ys.reserveCapacity(indices.count)
    let timePhase = .twoPi * wave.frequency * time
    let staticPhase = wave.phaseRadians
    let spatial = Double(config.cycles)

    for index in indices {
      let angle = timePhase + (spatial * .twoPi * index) + staticPhase
      let y = WaveSampler<Double>.value(for: wave.waveform, atRadians: angle)
      ys.append(wave.amplitude * y)
    }
    return ys
  }
}
