//
//  WaveAdjuster.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/1/2026.
//

import Foundation

public struct WaveParameterAdjuster {
  private var lastFrequency: Double
  private var lastPhase: Double
  private var lastSpacingWaveSpeed: Double
  
  private(set) var horizontalWaveTimeOffset: TimeInterval
  private(set) var spacingWaveTimeOffset: TimeInterval
  
  public init(
    initialFrequency: Double = 1.0,
    initialPhase: Double = 0.0,
    initialSpacingWaveSpeed: Double = 1.0
  ) {
    self.lastFrequency = initialFrequency
    self.lastPhase = initialPhase
    self.lastSpacingWaveSpeed = initialSpacingWaveSpeed
    self.horizontalWaveTimeOffset = 0.0
    self.spacingWaveTimeOffset = 0.0
  }
  
  
  /// Updates frequency while maintaining visual continuity
  /// - Parameters:
  ///   - frequency: The new frequency value
  ///   - currentPhase: The current phase value
  // Updates frequency while preserving the horizontal time–based argument.
  // The invariant is that (effectiveTime * frequency + phase) remains unchanged.
  public mutating func updateFrequency(to frequency: Double, currentPhase: Double) {
    let now = Date().timeIntervalSinceReferenceDate
    let effectiveTime = now - horizontalWaveTimeOffset
    // Preserve the current horizontal component.
    let currentArg = effectiveTime * lastFrequency + currentPhase
    // Solve for new effectiveTime such that newEffectiveTime * frequency + currentPhase equals currentArg.
    let newEffectiveTime = (currentArg - currentPhase) / frequency
    horizontalWaveTimeOffset = now - newEffectiveTime
    lastFrequency = frequency
  }
  
  
  /// Updates phase while maintaining visual continuity
  /// - Parameters:
  ///   - phase: The new phase value
  ///   - currentFrequency: The current frequency value
  // Updates phase while preserving continuity.
  public mutating func updatePhase(to phase: Double, currentFrequency: Double) {
    let now = Date().timeIntervalSinceReferenceDate
    let effectiveTime = now - horizontalWaveTimeOffset
    // Preserve the existing time–dependent value.
    let currentArg = effectiveTime * currentFrequency + lastPhase
    let newEffectiveTime = (currentArg - phase) / currentFrequency
    horizontalWaveTimeOffset = now - newEffectiveTime
    lastPhase = phase
  }
  
  // Updates spacingWaveSpeed for the vertical (breathing) effect.
  // For the spacing wave, the time-dependent term is effectiveTime * spacingWaveSpeed.
  public mutating func updateSpacingWaveSpeed(to newSpeed: Double) {
    let now = Date().timeIntervalSinceReferenceDate
    let effectiveTime = now - spacingWaveTimeOffset
    let currentArg = effectiveTime * lastSpacingWaveSpeed
    let newEffectiveTime = currentArg / newSpeed
    spacingWaveTimeOffset = now - newEffectiveTime
    lastSpacingWaveSpeed = newSpeed
  }
  
}
