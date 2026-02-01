//
//  WaveAdjuster.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 21/1/2026.
//

import Foundation

/// `Result = (CurrentTime – Origin) * Rate + Offset`
/// Manages a value that evolves over time (like phase or rotation)
/// and ensures transitions between different rates/offsets are seamless.
/// Domain‑specific to oscillation.
/// Look to this now instead of `WaveAttributeState`
public struct ContinuousParameter: Sendable {
  private var lastSyncTime: TimeInterval = 0
  private var accumulatedPhase: Float = 0
  
  public init() {}
  
  /// Call this once per frame (main thread). Use `frequency` for integration.
  public mutating func update(at now: TimeInterval, frequency: Float) {
    if lastSyncTime == 0 { lastSyncTime = now }
    let deltaTime = now - lastSyncTime
    accumulatedPhase += Float(deltaTime) * frequency
    lastSyncTime = now
  }
  
  /// Normalised phase in cycles [0,1).
  public var currentPhase: Float {
    accumulatedPhase - floor(accumulatedPhase)
  }
}

  
  /// Call this ONCE per frame before your drawing loop.
  /// It updates the internal phase based on how much time has passed.
//  public mutating func update(at now: TimeInterval, frequency: Double) {
//    if lastSyncTime == 0 { lastSyncTime = now }
//
//    let deltaTime = now - lastSyncTime
//    // Phase += Time * Frequency
//    accumulatedPhase += deltaTime * lastFrequency
//
//    // Save for next time
//    lastSyncTime = now
//    lastFrequency = frequency
//  }
//
//  /// Returns the current phase [0, 1)
//  public var currentPhase: Double {
//    accumulatedPhase - floor(accumulatedPhase)
//  }
//}
//public struct ContinuousParameter {
//  private var origin: TimeInterval = 0
//
//  public init() {}
//}
//
//extension ContinuousParameter {
//
//  /// Calculates the time-based phase (0...1) for a given frequency.
//  /// Previous form on `WaveAttributeState`:
//  /// `effectivePhase`
//  /// `let effectiveTime = currentTime - phaseOriginTime`
//  public func temporalPhase(
//    at now: TimeInterval,
//    frequency: Double
//  ) -> Double {
//    let effectiveTime = now - origin
//    let phase = effectiveTime * frequency
//    return phase - floor(phase)  // Wrap to [0, 1)
//  }
//
//  /// The "Magic" method: Adjusts the origin so that when frequency changes,
//  /// the phase remains identical at this exact moment.
//  public mutating func sync(
//    at now: TimeInterval,
//    oldFrequency: Double,
//    newFrequency: Double
//  ) {
//    if newFrequency == 0 { return }
//    let currentEffectiveTime = now - origin
//    let currentProgress = currentEffectiveTime * oldFrequency
//
//    // Solve: newEffectiveTime * newFrequency = currentProgress
//    let newEffectiveTime = currentProgress / newFrequency
//    self.origin = now - newEffectiveTime
//  }
//}
//  private var lastValue: CGFloat

//  public init(initialValue: CGFloat = 0.0, initialOrigin: TimeInterval = 0.0) {
//    self.lastValue = initialValue
//    self.origin = initialOrigin
//  }

/// Computes the "virtual time" needed to keep the output constant
/// when a parameter (like frequency) changes.
//  public mutating func sync(
//    to newValue: CGFloat,
//    at now: TimeInterval,
//    currentRate: CGFloat
//  ) {
//    let currentEffectiveTime = effectiveTime(at: now)
//    let currentArgument = currentEffectiveTime * currentRate
//
//    /// Solve for newEffectiveTime: `(newTime * newValue) == currentArgument`
//    let newEffectiveTime =
//      newValue != 0
//      ? currentArgument / newValue
//      : 0
//    self.origin = now - newEffectiveTime
//    self.lastValue = newValue
//  }
//
//  public func effectiveTime(at now: TimeInterval) -> TimeInterval {
//    now - origin
//  }
//
//  public func effectivePhase(
//    currentTime: TimeInterval,
//    frequency: CGFloat
//  ) -> CGFloat {
//    let t = effectiveTime(at: currentTime)
//    let phase = t * frequency
//    return phase - floor(phase)
//  }
//}

/// This is still fairly 'breathing' specific, hoping to simplify further
//public struct WaveState {
//  /// Track the "Temporal Progress" of different wave components
//  private var primaryPhaseState = ContinuousParameter()
//  private var spacingState = ContinuousParameter()
//
//  /// You no longer need separate "lastFrequency" and "lastPhase" variables
//  /// inside here if you pass them into the sync methods.
//  public mutating func updatePrimary(frequency: CGFloat, at now: TimeInterval) {
//    // This handles the "visual continuity" logic internally
//    primaryPhaseState.sync(to: frequency, at: now, currentRate: frequency)
//  }
//
//  public func effectivePhase(currentTime: TimeInterval, frequency: CGFloat) -> CGFloat {
//    let t = primaryPhaseState.effectiveTime(at: currentTime)
//    let phase = t * frequency
//    return phase - floor(phase)
//  }
//}

///// A runtime complement to `WaveShaped`
///// `WaveShaped` describes what a wave is (frequency, amplitude, phase, waveform)
///// `WaveAttributeState` tracks how to evaluate it smoothly over time
//public struct WaveAttributeState {
//  private var lastFrequency: Double
//  private var lastPhase: Double
//  private var lastSpacingWaveSpeed: Double
//
//  /// this is the “time that corresponds to phase = 0” (or the origin of your phase calculation).
//  private(set) public var phaseOriginTime: TimeInterval
//  private(set) public var verticalWaveTimeOffset: TimeInterval
//
//  public init(
//    initialFrequency: Double = 1.0,
//    initialPhase: Double = 0.0,
//    initialSpacingWaveSpeed: Double = 1.0
//  ) {
//    self.lastFrequency = initialFrequency
//    self.lastPhase = initialPhase
//    self.lastSpacingWaveSpeed = initialSpacingWaveSpeed
//    self.phaseOriginTime = 0.0
//    self.verticalWaveTimeOffset = 0.0
//  }
//}
//
//extension WaveAttributeState {
//
//  /// Compute effective phase including time, normalizedIndex, and cycles
//  public func effectivePhase(
//    currentTime: TimeInterval,
//    normalisedIndex: Double,
//    cycles: Double,
//    frequency: Double? = nil,
//    phaseOffset: Double? = nil
//  ) -> Double {
//    let f = frequency ?? lastFrequency
//    let p = phaseOffset ?? lastPhase
//    let effectiveTime = currentTime - phaseOriginTime
//    let phase = effectiveTime * f + normalisedIndex * cycles + p
//    return phase - floor(phase)  // wrap into [0,1)
//  }
//
//  /// Updates frequency while maintaining visual continuity
//  /// The invariant is that (`effectiveTime * frequency + phase`) remains unchanged.
//  /// - Parameters:
//  ///   - frequency: The new frequency value
//  ///   - currentPhase: The current phase value
//  public mutating func updateFrequency(to frequency: Double, currentPhase: Double) {
//    let now = Date().timeIntervalSinceReferenceDate
//    let effectiveTime = now - phaseOriginTime
//    let currentArg = effectiveTime * lastFrequency + currentPhase
//    let newEffectiveTime = (currentArg - currentPhase) / frequency
//    phaseOriginTime = now - newEffectiveTime
//    lastFrequency = frequency
//  }
//
//  /// Updates phase while maintaining visual continuity
//  /// - Parameters:
//  ///   - phase: The new phase value
//  ///   - currentFrequency: The current frequency value
//  public mutating func updatePhase(to phase: Double, currentFrequency: Double) {
//    let now = Date().timeIntervalSinceReferenceDate
//    let effectiveTime = now - phaseOriginTime
//    let currentArg = effectiveTime * currentFrequency + lastPhase
//    let newEffectiveTime = (currentArg - phase) / currentFrequency
//    phaseOriginTime = now - newEffectiveTime
//    lastPhase = phase
//  }
//
//  /// Updates spacingWaveSpeed for the vertical (breathing) effect.
//  /// For the spacing wave, the time-dependent term is effectiveTime * spacingWaveSpeed.
//  public mutating func updateSpacingWaveSpeed(to newSpeed: Double) {
//    let now = Date().timeIntervalSinceReferenceDate
//    let effectiveTime = now - verticalWaveTimeOffset
//    let currentArg = effectiveTime * lastSpacingWaveSpeed
//    let newEffectiveTime = currentArg / newSpeed
//    verticalWaveTimeOffset = now - newEffectiveTime
//    lastSpacingWaveSpeed = newSpeed
//  }
//
//}
