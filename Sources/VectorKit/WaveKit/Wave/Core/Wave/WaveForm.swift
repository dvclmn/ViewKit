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
  /// the “wave shape function” — only depends on phase
  /// phase `∈ [0, 1)`
  public func sample(phase: Float, isFastMode: Bool = true) -> Float {
    let p = phase.truncatingRemainder(dividingBy: 1)
    //    let p = phase - floor(phase)  // wrap to [0, 1)
    return isFastMode
      ? FastWaveSampler.value(for: self, at: p)
      : WaveSampler.value(for: self, at: p)
  }

}

public struct FastWaveSampler {
  // Optionally: Precompute a sine table once
  static let sineTable: [Float] = (0..<1024).map { i in
    sin(Float(i) * 2 * .pi / 1024)
  }

  public static func fastSinTable(_ phase: Float) -> Float {
    let idx = Int((phase.truncatingRemainder(dividingBy: 1) * 1024))
    return sineTable[idx & 1023]
  }

  public static func value(for waveform: Waveform, at phase: Float) -> Float {
    let p = phase.truncatingRemainder(dividingBy: 1)
    switch waveform {
      case .sine:
        return fastSinTable(p)
      case .triangle:
        return 2 * abs(2 * (p - 0.5)) - 1
      case .sawtooth:
        return 2 * (p - 0.5)
      case .square:
        return p < 0.5 ? 1.0 : -1.0
    }
  }
}

public struct WaveSampler {
  /// Evaluates a waveform at a specific phase.
  public static func value(
    for waveform: Waveform,
    at phase: Float
  ) -> Float {
    switch waveform {
      //      case .sine: fastSin(phase * 2 * .pi)
      case .sine: sin(phase * 2 * .pi)
      case .triangle: 2 * abs(2 * (phase - floor(phase + 0.5))) - 1
      case .sawtooth: 2 * (phase - floor(phase + 0.5))
      case .square: phase - floor(phase) < 0.5 ? 1.0 : -1.0
    }
  }
  //  private static func fastSin(_ x: Float) -> Float {
  //    // Wrap input angle to [-π, π] for better accuracy
  //    let x = x.truncatingRemainder(dividingBy: 2 * .pi)
  //    // Bhaskara I’s sine approximation
  //    return (16 * x * (.pi - x)) / (5 * .pi * .pi - 4 * x * (.pi - x))
  //  }
}
