//
//  WaveConfig.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import Foundation

public struct WaveConfig: Hashable, Sendable, Codable {
  public var cycles: CGFloat
  public var dashes: Int
  public var dashePhase: CGFloat

  public var sampleCount: Int
  public var interpolation: WaveInterpolation

  public init(
    cycles: CGFloat = 3,
    dashes: Int = 0,
    dashePhase: CGFloat = 0,
    sampleCount: Int = 30,
    interpolation: WaveInterpolation = .cubic,
  ) {
    self.cycles = cycles
    self.dashes = dashes
    self.dashePhase = dashePhase
    self.sampleCount = sampleCount
    self.interpolation = interpolation
  }
}
