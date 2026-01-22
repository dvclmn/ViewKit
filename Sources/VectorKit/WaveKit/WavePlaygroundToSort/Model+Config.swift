//
//  Model+Config.swift
//  AnimationPlayground
//
//  Created by Dave Coleman on 1/2/2025.
//

import Foundation

public struct WaveConfig: Codable, Sendable {
  /// The base circle radius.
  public var circleRadius: CGFloat = 15

  /// Horizontal left/right motion parameters.
  public var horizontalWave: WaveModulator =
    WaveModulator(
      isEnabled: true,
      amp: 70,
      freq: 2,
      phase: 0.4,
      cycles: 3
    )

  // Vertical spacing between circles (used when shouldMaintainHeight == false).
  public var spacing: CGFloat = 16

  // Breathing (spacing) wave: modulates the vertical position.
  // (When shouldMaintainHeight is true, the circles are laid out
  //  over a fixed height, and then the breathing effect is added.)
  public var spacingWave: WaveModulator =
    WaveModulator(
      isEnabled: true,
      amp: 10,
      freq: 1,
      phase: 0,
      cycles: 3)
  // When shouldMaintainHeight is true, no matter what count is,
  // these circles are “packed” into this height.
  public var height: CGFloat = 100
  public var shouldMaintainHeight: Bool = false

  // The total number of circles (affects normalization but not the wave shapes).
  public var count: Int = 20

  // New: a modulation for the circle radius (so the circles can “pulse”).
  public var radiusWave: WaveModulator =
    WaveModulator(
      isEnabled: true,
      amp: 5,
      freq: 1,
      phase: 0,
      cycles: 3)

  public init() {}
}

//struct WaveConfig: Codable {
//  var circleRadius: CGFloat = 15
//
//  /// `height` and `waveCount` only relevant
//  /// when ``shouldMaintainHeight`` is `true`
//  var height: CGFloat = 100
//  var waveCount: Double = 3
//
//  /// Only relevant when ``shouldMaintainHeight`` is `false`
//  var spacing: CGFloat = 16
//
//  /// Horizontal sine wave (left/right)
//  var width: CGFloat = 70
//  var speed: CGFloat = 2
//  var phase: CGFloat = 0.4
//  var count: Double = 20
//  var shouldMaintainHeight: Bool = false
//
//  /// New properties for vertical spacing wave ("breathing")
//  var spacingWaveEnabled: Bool = true
//
//  /// How much extra offset to add/subtract
//  var spacingWaveAmplitude: CGFloat = 10
//
//  /// Speed at which the spacing wave travels
//  var spacingWaveSpeed: CGFloat = 1
//
//  var spacingWaveCount: Double = 3
//}
