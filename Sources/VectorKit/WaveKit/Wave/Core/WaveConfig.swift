//
//  WaveConfig.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import Foundation

public struct WaveConfig: Hashable, Sendable, Codable {
  let isEnabled: Bool
  let cycles: Int
  let sampleCount: Int
  let interpolation: WaveInterpolation
  
  public init(
    isEnabled: Bool = true,
    cycles: Int = 3,
    sampleCount: Int = 30,
    interpolation: WaveInterpolation = .cubic,
  ) {
    self.isEnabled = isEnabled
    self.cycles = cycles
    self.sampleCount = sampleCount
    self.interpolation = interpolation
  }
}


/// Note: See Swift Charts `InterpolationMethod`, possibly helpful
/// https://developer.apple.com/documentation/charts/interpolationmethod
public enum WaveInterpolation: Sendable, Equatable, Codable {
  case catmullRom
  case linear
  case cubic
}
