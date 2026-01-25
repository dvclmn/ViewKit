//
//  WaveForm.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/1/2026.
//

import Foundation

public enum Waveform: String, Sendable, Codable, Hashable {
  case sine
  case triangle
  case square
  case sawtooth
}

extension Waveform {
  /// the “wave shape function” — only depends on phase
  /// phase `∈ [0, 1)`
  public func sample(phase: Double) -> Double {
    let p = phase - floor(phase)  // wrap to [0, 1)

    return switch self {
      case .sine: sin(p * 2 * .pi)
      case .triangle: 1 - 4 * abs(p - 0.5)
      case .square: p < 0.5 ? 1 : -1
      case .sawtooth: 2 * p - 1
    }
  }
}
