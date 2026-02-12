//
//  WaveConfig.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import Foundation

/// Configuration for a single wave. Effects that are noticable
/// even when this single wave is combined with other waves.
public struct WaveConfig: Hashable, Sendable, Codable, Equatable {
  
  /// Works well applied to a single wave, even when combined into another wave
  /// Aka the effect is still noticeable
  public var cycles: Double
  public var noise: Double

  public init(
    cycles: Double = 3,
//    sampleCount: Int = 30,
//    interpolation: WaveInterpolation = .cubic(),
    noise: Double = 0
  ) {
    self.cycles = cycles
//    self.sampleCount = sampleCount
//    self.interpolation = interpolation
    self.noise = noise
  }
}
