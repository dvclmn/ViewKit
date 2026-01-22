//
//  Model+Wave.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/1/2026.
//

import Foundation

public struct Wave: WaveShaped, Sendable, Identifiable, Hashable, Codable {
  public let id: UUID
  public var frequency: Double
  public var amplitude: Double
  public var phase: Double

  public init(
    id: UUID = UUID(),
    frequency: Double,
    amplitude: Double,
    phase: Double
  ) {
    self.id = id
    self.frequency = frequency
    self.amplitude = amplitude
    self.phase = phase
  }
}

extension Wave {
  public init(
    freq: Double,
    amp: Double,
    phase: Double,
  ) {
    self.init(
      frequency: freq,
      amplitude: amp,
      phase: phase
    )
  }
}

public struct NoisyWave: Sendable, Hashable {
  public let wave: Wave
  public var noise: Double
}
