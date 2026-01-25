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
  
  public init(
    isEnabled: Bool = true,
    cycles: Int = 3,
    sampleCount: Int = 30,
  ) {
    self.isEnabled = isEnabled
    self.cycles = cycles
    self.sampleCount = sampleCount
  }
}
