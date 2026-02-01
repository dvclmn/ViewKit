//
//  WaveForm.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/1/2026.
//

import Foundation

public enum Waveform: String, Sendable, Codable, Hashable, CaseIterable, Identifiable {
  case sine
  case triangle
  case square
  case sawtooth

  public var id: String { rawValue }
  public var name: String { rawValue.capitalized }
}

extension Waveform {
  /// No need to provide a pre-normalised value for `phase`.
  /// This will be handled in ``WaveSampler/value(for:at:)``
  public func sample(phase: Float) -> Float {
    WaveSampler.value(for: self, at: phase)
  }
}
