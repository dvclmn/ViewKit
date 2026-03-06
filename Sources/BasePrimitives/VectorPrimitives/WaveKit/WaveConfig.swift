//
//  WaveConfig.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import Foundation

/// Configuration for a single wave. Effects that are noticable
/// even when this single wave is combined with other waves.
///
/// Note: previously held `sampleCount` and `interpolation`,
/// both of which have moved to ``ConfiguredWaveStack``
public struct WaveConfig: Hashable, Sendable, Codable, Equatable {
  public var cycles: Double
  public var noise: Double

  public init(
    cycles: Double = 3,
    noise: Double = 0
  ) {
    self.cycles = cycles
    self.noise = noise
  }
}
