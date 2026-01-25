//
//  Model+Wave.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/1/2026.
//

import Foundation

public struct Wave: WaveShaped, Sendable, Identifiable, Hashable, Codable {
  public let id: UUID
  public var frequency: CGFloat
  public var amplitude: CGFloat
  public var phase: CGFloat
  public var waveform: Waveform

  public init(
    id: UUID = UUID(),
    freq: CGFloat,
    amp: CGFloat,
    phase: CGFloat,
    form: Waveform = .sine
  ) {
    self.id = id
    self.frequency = freq
    self.amplitude = amp
    self.phase = phase
    self.waveform = form
  }
}

extension Wave {
}

public struct NoisyWave: Sendable, Hashable {
  public let wave: Wave
  public var noise: CGFloat
}
