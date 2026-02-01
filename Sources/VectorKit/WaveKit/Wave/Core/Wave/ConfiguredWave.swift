//
//  SubWave.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import Foundation

/// Previously handled by now-removed `WaveModulator`
public struct ConfiguredWave: Wavable, Identifiable, Hashable, Codable, Equatable {
  public typealias Value = Float
  public var id: FloatWave.ID { wave.id }
  public var wave: FloatWave
  public var config: FloatWaveConfig

  public init(_ wave: FloatWave, config: FloatWaveConfig = .init()) {
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
