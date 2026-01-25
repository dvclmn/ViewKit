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
  public var waveform: Waveform

  public init(
    id: UUID = UUID(),
    frequency: Double,
    amplitude: Double,
    phase: Double,
    waveform: Waveform,
  ) {
    self.id = id
    self.frequency = frequency
    self.amplitude = amplitude
    self.phase = phase
    self.waveform = waveform
  }
}

//extension Wave: RawRepresentable {
//  public init?(rawValue: String) {
//    <#code#>
//  }
//  
//  public var rawValue: String {
//    <#code#>
//  }
//  
//  public typealias RawValue = String
//  
//  
//}

extension Wave {
  public init(
    freq: Double,
    amp: Double,
    phase: Double,
    waveform: Waveform = .sine
  ) {
    self.init(
      frequency: freq,
      amplitude: amp,
      phase: phase,
      waveform: waveform,
    )
  }
}

public struct NoisyWave: Sendable, Hashable {
  public let wave: Wave
  public var noise: Double
}
