//
//  WaveConfig.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import Foundation

public struct WaveConfig: Hashable, Sendable, Codable, Equatable {
  public var cycles: CGFloat
  public var sampleCount: Int
  public var interpolation: WaveInterpolation
  public var noise: CGFloat

  public init(
    cycles: CGFloat = 3,
    sampleCount: Int = 30,
    interpolation: WaveInterpolation = .cubic,
    noise: CGFloat = 0
  ) {
    self.cycles = cycles
    self.sampleCount = sampleCount
    self.interpolation = interpolation
    self.noise = noise
  }
}
