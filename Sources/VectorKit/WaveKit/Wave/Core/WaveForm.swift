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
  public func sample(phase: CGFloat) -> CGFloat {
    let p = phase - floor(phase)  // wrap to [0, 1)
    return WaveSampler.value(for: self, at: p)
//    return switch self {
//      case .sine: sin(p * 2 * CGFloat.pi)
//      case .triangle: 1 - 4 * abs(p - 0.5)
//      case .square: p < 0.5 ? 1 : -1
//      case .sawtooth: 2 * p - 1
//    }
  }
}

public struct WaveSampler {
  /// Evaluates a waveform at a specific phase.
  /// This is where you'd put logic for your Sine, Square, Triangle, etc.
  public static func value(
    for waveform: Waveform,
    at phase: Double
  ) -> Double {
    switch waveform {
      case .sine: sin(phase * 2 * .pi)
      case .triangle: 2 * abs(2 * (phase - floor(phase + 0.5))) - 1
      case .sawtooth: 2 * (phase - floor(phase + 0.5))
      case .square: phase - floor(phase) < 0.5 ? 1.0 : -1.0
    }
  }
}
