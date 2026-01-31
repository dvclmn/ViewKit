//
//  SubWave.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import Foundation

/// Previously handled by now-removed `WaveModulator`
//@dynamicMemberLookup
public struct ConfiguredWave: Identifiable, Hashable, Sendable, Codable, Equatable, Wavable {
  public var id: Wave.ID { wave.id }
  public var wave: Wave
  public var config: WaveConfig

  public init(
    _ wave: Wave,
    config: WaveConfig = .init()
  ) {
    self.wave = wave
    self.config = config
  }
}

extension ConfiguredWave {
  public static let example01: Self = .init(
    .example01,
    config: .init()
  )

  public static let example02: Self = .init(
    .example02,
    config: WaveConfig(cycles: 10, sampleCount: 10)
  )
}
