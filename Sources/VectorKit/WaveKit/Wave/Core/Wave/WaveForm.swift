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
  public func sample(
    phase: CGFloat,
    //    isFastMode: Bool = true
  ) -> CGFloat {
    let p = Float(phase.truncatingRemainder(dividingBy: 1))
    return CGFloat(FastWaveSampler.value(for: self, at: p))
    //    let p = phase - floor(phase)  // wrap to [0, 1)
    //    return isFastMode
    //      ?
    //      : WaveSampler.value(for: self, at: p)
  }

}

//public struct FastWaveSampler {
//  static let sineTable: [CGFloat] = (0..<1024).map { i in
//    let index = CGFloat(i) * 2 * .pi / 1024
//    return sin(index)
//  }
//
//  public static func fastSinTable(_ phase: CGFloat) -> CGFloat {
//    let idx = Int((phase.truncatingRemainder(dividingBy: 1) * 1024))
//    return CGFloat(sineTable[idx & 1023])
//  }
//
//  public static func value(
//    for waveform: Waveform,
//    at phase: CGFloat
//  ) -> CGFloat {
//    let p = phase.truncatingRemainder(dividingBy: 1)
//    return switch waveform {
//      case .sine: fastSinTable(p)
//      case .triangle: 2 * abs(2 * (p - 0.5)) - 1
//      case .sawtooth: 2 * (p - 0.5)
//      case .square: p < 0.5 ? 1.0 : -1.0
//    }
//  }
//}
//
//public struct WaveSampler {
//  /// Evaluates a waveform at a specific phase.
//  public static func value(
//    for waveform: Waveform,
//    at phase: CGFloat
//  ) -> CGFloat {
//    switch waveform {
//      case .sine: sin(phase * 2 * CGFloat.pi)
//      case .triangle: 2 * abs(2 * (phase - floor(phase + 0.5))) - 1
//      case .sawtooth: 2 * (phase - floor(phase + 0.5))
//      case .square: phase - floor(phase) < 0.5 ? 1.0 : -1.0
//    }
//  }
//}
