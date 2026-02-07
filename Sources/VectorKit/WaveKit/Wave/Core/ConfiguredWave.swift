//
//  SubWave.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import Foundation

/// Previously handled by now-removed `WaveModulator`
public struct ConfiguredWave: WaveShaped, Sendable, Identifiable, Hashable, Codable, Equatable {
  public typealias Value = Double
  public var id: FloatWave.ID { wave.id }
  public var wave: FloatWave
  public var config: FloatWaveConfig

  public init(_ wave: FloatWave = .example01, config: FloatWaveConfig = .init()) {
    self.wave = wave
    self.config = config
  }
}

extension ConfiguredWave {
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
  public static var example01: Self {
    .init(
      .example01,
      config: .init()
    )
  }

  public static var example02: Self {
    .init(
      .example02,
      config: FloatWaveConfig(cycles: 10, sampleCount: 10)
    )
  }
}
