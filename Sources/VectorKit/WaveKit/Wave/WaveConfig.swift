//
//  WaveConfig.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import Foundation

//public typealias FloatWaveConfig = WaveConfig<Double>
//public typealias FloatWaveConfig = WaveConfig<Float>

public struct WaveConfig: Hashable, Sendable, Codable, Equatable {
  //public struct WaveConfig<T: WaveFloat>: Hashable, Sendable, Codable, Equatable {
  public var cycles: Double
  public var sampleCount: Int
  public var interpolation: WaveInterpolation
  public var noise: Double

  public init(
    cycles: Double = 3,
    sampleCount: Int = 30,
    interpolation: WaveInterpolation = .cubic(),
    noise: Double = 0
  ) {
    self.cycles = cycles
    self.sampleCount = sampleCount
    self.interpolation = interpolation
    self.noise = noise
  }
}
