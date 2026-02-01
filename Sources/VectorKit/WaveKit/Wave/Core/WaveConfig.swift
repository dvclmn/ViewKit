//
//  WaveConfig.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import Foundation
public typealias FloatWaveConfig = WaveConfig<Float>

public struct WaveConfig<T: WaveFloat>: Hashable, Sendable, Codable, Equatable {
  public var cycles: T
  public var sampleCount: Int
  public var interpolation: WaveInterpolation
  public var noise: T

  public init(
    cycles: T = 3,
    sampleCount: Int = 30,
    interpolation: WaveInterpolation = .cubic,
    noise: T = 0
  ) {
    self.cycles = cycles
    self.sampleCount = sampleCount
    self.interpolation = interpolation
    self.noise = noise
  }
}
