//
//  Model+Config.swift
//  AnimationPlayground
//
//  Created by Dave Coleman on 1/2/2025.
//

import Foundation

struct WaveConfig: Codable {
  // The base circle radius.
  var circleRadius: CGFloat = 15

  // Horizontal left/right motion parameters.
  var horizontalWave: WaveModulator =
    WaveModulator(
      isEnabled: true,
      amplitude: 70,
      speed: 2,
      phase: 0.4,
      cycles: 3)

  // Vertical spacing between circles (used when shouldMaintainHeight == false).
  var spacing: CGFloat = 16

  // Breathing (spacing) wave: modulates the vertical position.
  // (When shouldMaintainHeight is true, the circles are laid out
  //  over a fixed height, and then the breathing effect is added.)
  var spacingWave: WaveModulator =
    WaveModulator(
      isEnabled: true,
      amplitude: 10,
      speed: 1,
      phase: 0,
      cycles: 3)
  // When shouldMaintainHeight is true, no matter what count is,
  // these circles are “packed” into this height.
  var height: CGFloat = 100
  var shouldMaintainHeight: Bool = false

  // The total number of circles (affects normalization but not the wave shapes).
  var count: Int = 20

  // New: a modulation for the circle radius (so the circles can “pulse”).
  var radiusWave: WaveModulator =
    WaveModulator(
      isEnabled: true,
      amplitude: 5,
      speed: 1,
      phase: 0,
      cycles: 3)
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

//struct WaveParameterAdjuster {
//  private var lastFrequency: Double
//  private var lastPhase: Double
//  private var lastSpacingWaveSpeed: Double
//
//  private(set) var horizontalWaveTimeOffset: TimeInterval
//  private(set) var spacingWaveTimeOffset: TimeInterval
//
//  init(
//    initialFrequency: Double = 1.0,
//    initialPhase: Double = 0.0,
//    initialSpacingWaveSpeed: Double = 1.0
//  ) {
//    self.lastFrequency = initialFrequency
//    self.lastPhase = initialPhase
//    self.lastSpacingWaveSpeed = initialSpacingWaveSpeed
//    self.horizontalWaveTimeOffset = 0.0
//    self.spacingWaveTimeOffset = 0.0
//  }
//
//
//  /// Updates frequency while maintaining visual continuity
//  /// - Parameters:
//  ///   - frequency: The new frequency value
//  ///   - currentPhase: The current phase value
//  // Updates frequency while preserving the horizontal time–based argument.
//  // The invariant is that (effectiveTime * frequency + phase) remains unchanged.
//  mutating func updateFrequency(to frequency: Double, currentPhase: Double) {
//    let now = Date().timeIntervalSinceReferenceDate
//    let effectiveTime = now - horizontalWaveTimeOffset
//    // Preserve the current horizontal component.
//    let currentArg = effectiveTime * lastFrequency + currentPhase
//    // Solve for new effectiveTime such that newEffectiveTime * frequency + currentPhase equals currentArg.
//    let newEffectiveTime = (currentArg - currentPhase) / frequency
//    horizontalWaveTimeOffset = now - newEffectiveTime
//    lastFrequency = frequency
//  }
//
//
//  /// Updates phase while maintaining visual continuity
//  /// - Parameters:
//  ///   - phase: The new phase value
//  ///   - currentFrequency: The current frequency value
//  // Updates phase while preserving continuity.
//  mutating func updatePhase(to phase: Double, currentFrequency: Double) {
//    let now = Date().timeIntervalSinceReferenceDate
//    let effectiveTime = now - horizontalWaveTimeOffset
//    // Preserve the existing time–dependent value.
//    let currentArg = effectiveTime * currentFrequency + lastPhase
//    let newEffectiveTime = (currentArg - phase) / currentFrequency
//    horizontalWaveTimeOffset = now - newEffectiveTime
//    lastPhase = phase
//  }
//
//  // Updates spacingWaveSpeed for the vertical (breathing) effect.
//  // For the spacing wave, the time-dependent term is effectiveTime * spacingWaveSpeed.
//  mutating func updateSpacingWaveSpeed(to newSpeed: Double) {
//    let now = Date().timeIntervalSinceReferenceDate
//    let effectiveTime = now - spacingWaveTimeOffset
//    let currentArg = effectiveTime * lastSpacingWaveSpeed
//    let newEffectiveTime = currentArg / newSpeed
//    spacingWaveTimeOffset = now - newEffectiveTime
//    lastSpacingWaveSpeed = newSpeed
//  }
//
//}
