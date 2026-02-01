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
