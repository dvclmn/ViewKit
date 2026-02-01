//
//  Model+Wave.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/1/2026.
//

import Foundation

public typealias FloatWave = Wave<Float>

/// Think of a wave as having two "engines" that determine its position:
///
/// ## Time (When you are)
/// - The Motor
/// - Handled by ``ContinuousParameter``
/// - Constantly moves the wave forward.
///
/// ## Space (Where you are)
/// - The Coordinate
/// - The `normalisedIndex`
/// - In a SwiftUI Canvas, 0.0 might be the left edge and 1.0 the right edge;
///   and Cycles is how many "humps" of the wave fit into that space.
public struct Wave<T: WaveFloat>: Sendable, Identifiable, Hashable, Equatable, Codable {
  public let id: UUID
  public var amplitude: T
  public var frequency: T
  public var phase: T
  public var waveform: Waveform

  public init(
    id: UUID = UUID(),
    amp: T,
    freq: T,
    phase: T,
    waveform: Waveform = .sine
  ) {
    self.id = id
    self.amplitude = amp
    self.frequency = freq
    self.phase = phase
    self.waveform = waveform
  }
}

extension Wave {
  public var omega: T { frequency.omega }

  public static var example01: Self {
    .init(
      amp: 8,
      freq: 3,
      phase: 0,
      waveform: .sine
    )
  }

  public static var example02: Self {
    .init(
      amp: 30,
      freq: 10,
      phase: 0,
      waveform: .sine
    )
  }
}
