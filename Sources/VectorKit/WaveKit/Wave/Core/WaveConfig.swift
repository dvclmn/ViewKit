//
//  WaveConfig.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/1/2026.
//

import Foundation

public struct WaveConfig: Hashable, Sendable, Codable {
  public let isEnabled: Bool
  public let cycles: CGFloat
//  public let cycles: Int
  public let sampleCount: Int
  public let interpolation: WaveInterpolation
  /// From old `WaveAppearance`
  //  static var windowOptions: [CGFloat] { [1, 2, 4, 8, 12, 24, 30] }
  //  static var timeRange: ClosedRange<CGFloat> { 1...30 }
  
  public init(
    isEnabled: Bool = true,
    cycles: CGFloat = 3,
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
