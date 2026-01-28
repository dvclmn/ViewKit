//
//  Model+Wave.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/1/2026.
//

import Foundation

/// Think of a wave as having two "engines" that determine its position:
/// Time (when you are) and Space (where you are).
///
/// - Time (The Motor): This is handled by your ContinuousParameter. It constantly moves the wave forward.
/// - Space (The Coordinate): This is your normalisedIndex. In a SwiftUI Path or Canvas,
///   0.0 might be the left edge and 1.0 the right edge.
/// - Cycles: This is how many "humps" of the wave fit into that space.
public struct Wave: Sendable, Identifiable, Hashable, Equatable, Codable {
  public let id: UUID
  public var frequency: Float
  public var amplitude: Float
  public var phase: Float
  public var waveform: Waveform

  public init(
    id: UUID = UUID(),
    freq: Float,
    amp: Float,
    phase: Float,
    waveform: Waveform = .sine
  ) {
    self.id = id
    self.frequency = freq
    self.amplitude = amp
    self.phase = phase
    self.waveform = waveform
  }
}

extension Wave {
  public static let example01: Self = .init(
    freq: 3,
    amp: 8,
    phase: 0,
    waveform: .sine
  )
  
  public static let example02: Self = .init(
    freq: 10,
    amp: 30,
    phase: 0,
    waveform: .sine
  )
}

public struct NoisyWave: Sendable, Hashable {
  public let wave: Wave
  public var noise: Float
}
