//
//  WaveAdjuster.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/1/2026.
//

import Foundation

/// A runtime complement to `WaveShaped`
/// `WaveShaped` describes what a wave is (frequency, amplitude, phase, waveform)
/// `WaveAttributeState` tracks how to evaluate it smoothly over time
public struct WaveAttributeState {
  private var lastFrequency: Double
  private var lastPhase: Double
  private var lastSpacingWaveSpeed: Double

  /// this is the “time that corresponds to phase = 0” (or the origin of your phase calculation).
  private(set) public var phaseOriginTime: TimeInterval
  private(set) public var verticalWaveTimeOffset: TimeInterval

  public init(
    initialFrequency: Double = 1.0,
    initialPhase: Double = 0.0,
    initialSpacingWaveSpeed: Double = 1.0
  ) {
    self.lastFrequency = initialFrequency
    self.lastPhase = initialPhase
    self.lastSpacingWaveSpeed = initialSpacingWaveSpeed
    self.phaseOriginTime = 0.0
    self.verticalWaveTimeOffset = 0.0
  }
}

extension WaveAttributeState {

  /// Compute effective phase including time, normalizedIndex, and cycles
  public func effectivePhase(
    currentTime: TimeInterval,
    normalisedIndex: Double,
    cycles: Double,
    frequency: Double? = nil,
    phaseOffset: Double? = nil
  ) -> Double {
    let f = frequency ?? lastFrequency
    let p = phaseOffset ?? lastPhase
    let effectiveTime = currentTime - phaseOriginTime
    let phase = effectiveTime * f + normalisedIndex * cycles + p
    return phase - floor(phase)  // wrap into [0,1)
  }

  /// Updates frequency while maintaining visual continuity
  /// The invariant is that (`effectiveTime * frequency + phase`) remains unchanged.
  /// - Parameters:
  ///   - frequency: The new frequency value
  ///   - currentPhase: The current phase value
  public mutating func updateFrequency(to frequency: Double, currentPhase: Double) {
    let now = Date().timeIntervalSinceReferenceDate
    let effectiveTime = now - phaseOriginTime
    let currentArg = effectiveTime * lastFrequency + currentPhase
    let newEffectiveTime = (currentArg - currentPhase) / frequency
    phaseOriginTime = now - newEffectiveTime
    lastFrequency = frequency
  }

  /// Updates phase while maintaining visual continuity
  /// - Parameters:
  ///   - phase: The new phase value
  ///   - currentFrequency: The current frequency value
  // Updates phase while preserving continuity.
  public mutating func updatePhase(to phase: Double, currentFrequency: Double) {
    let now = Date().timeIntervalSinceReferenceDate
    let effectiveTime = now - phaseOriginTime
    let currentArg = effectiveTime * currentFrequency + lastPhase
    let newEffectiveTime = (currentArg - phase) / currentFrequency
    phaseOriginTime = now - newEffectiveTime
    lastPhase = phase
  }

  /// Updates spacingWaveSpeed for the vertical (breathing) effect.
  /// For the spacing wave, the time-dependent term is effectiveTime * spacingWaveSpeed.
  public mutating func updateSpacingWaveSpeed(to newSpeed: Double) {
    let now = Date().timeIntervalSinceReferenceDate
    let effectiveTime = now - verticalWaveTimeOffset
    let currentArg = effectiveTime * lastSpacingWaveSpeed
    let newEffectiveTime = currentArg / newSpeed
    verticalWaveTimeOffset = now - newEffectiveTime
    lastSpacingWaveSpeed = newSpeed
  }

}
