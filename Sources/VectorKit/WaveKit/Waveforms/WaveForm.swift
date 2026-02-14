//
//  WaveForm.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/1/2026.
//

import Foundation

public enum Waveform: Sendable, Codable, Equatable, Hashable, CaseIterable, Identifiable {

  public static let allCases: [Waveform] = [
    .sine(mode: .math),
    .sine(mode: .table),
    .triangle,
    .square,
    .sawtooth,
  ]
  
  case sine(mode: SineMode = .table)
  case triangle
  case square
  case sawtooth
  
  public static let sineDefault: Self = .sine(mode: .table)

  public var id: String { name }
  public var name: String {
    switch self {
      case .sine(let mode): "Sine (\(mode.name))"
      case .triangle: "Triangle"
      case .square: "Square"
      case .sawtooth: "SawTooth"
    }
  }
}

extension Waveform {
  /// No need to provide a pre-normalised value for `phase`.
  /// This will be handled in ``WaveSampler/value(for:at:)``
  //  public func sample<T: WaveFloat>(phase: T) -> T {
  //  public func sample(phase: Float) -> Float {
  //    WaveSampler<T>.value(for: self, at: phase)
  //  }
}

public enum SineMode: String, CaseIterable, Equatable, Identifiable, Sendable, Codable {
  case math
  case table

  public var id: String { rawValue }
  public var name: String { rawValue.capitalized }
}
