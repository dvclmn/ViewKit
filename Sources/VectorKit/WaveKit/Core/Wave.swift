//
//  Model+Wave.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 22/1/2026.
//

import Foundation
import MetaCodable

public typealias FloatWave = Wave<Double>

/// Think of a wave as having two "engines" that determine its position:
///
/// ## Time (When you are)
/// - The Motor
/// - Handled by ``ContinuousParameter``
/// - Constantly moves the wave forward.
///
/// ## Space (Where you are)
/// - The Coordinate
/// - The `normalisedIndex`
/// - In a SwiftUI Canvas, 0.0 might be the left edge and 1.0 the right edge;
///   and Cycles is how many "humps" of the wave fit into that space.
@Codable
public struct Wave<T: WaveFloat>: Sendable, Identifiable, Hashable, Equatable, Codable {
  public let id: UUID
  public var amplitude: T

  /// Interpret as cycles per second (Hz) if you animate with time,
  /// or as cycles per unit-x if you sample across a normalised width.
  public var frequency: T

  @CodedAt("phase") private var phase: UnitPhase<T>  // <- canonical

  public var waveform: Waveform

  public init(
    id: UUID = UUID(),
    amp: T,
    freq: T,
    phaseTurns: T,
    waveform: Waveform = .sine
  ) {
    self.id = id
    self.amplitude = amp
    self.frequency = freq
    self.phase = UnitPhase(phaseTurns)
    self.waveform = waveform
  }

  //  public init(
  //    id: UUID = UUID(),
  //    amp: T,
  //    freq: T,
  //    phase: T,
  //    waveform: Waveform = .sine
  //  ) {
  //    self.id = id
  //    self.amplitude = amp
  //    self.frequency = freq
  //    self._phase = Self.wrapToTwoPi(phase)
  //    self.waveform = waveform
  //  }
}

extension Wave {

  public var unitPhase: T {
    get { phase.turns }
    set { phase = UnitPhase(newValue) }
  }

  public var phaseRadians: T {
    get { phase.radians }
    set { phase = UnitPhase(RadiansPhase(newValue).turns) }
  }

  public mutating func advancePhaseTurns(by dTurns: T) {
    phase.advance(by: dTurns)
  }

  /// Advancing phase: make it align with frequency’s meaning
  /// If frequency is Hz and you have a time step,
  ///
  /// If frequency is “cycles across width” and you’re scrolling phase to create motion,
  /// you’ll probably do something similar but driven by “speed” rather than dt. Still turns.
  public mutating func tick(dt: T) {
    // cycles/sec * sec = cycles (turns)
    advancePhaseTurns(by: frequency * dt)
  }

  /// Expose phase in radians with get/set
  //  public var phaseRadians: T {
  //    get { _phase }
  //    set { _phase = Self.wrapToTwoPi(newValue) }
  //  }
  //
  //  /// Expose unit phase [0, 1) with get/set
  //  public var unitPhase: T {
  //    get { Self.radiansToUnit(_phase) }
  //    set { _phase = Self.unitToRadians(Self.wrapUnit(newValue)) }
  //  }

  public mutating func update(
    _ newValue: T,
    in range: ClosedRange<T>? = nil,
    keyPath: WritableKeyPath<Self, T>
  ) {
    self[keyPath: keyPath] = newValue.clampedIfNeeded(to: range)
  }

  public mutating func updateDelta(
    _ newDelta: T,
    in range: ClosedRange<T>? = nil,
    keyPath: WritableKeyPath<Self, T>
  ) {
    let adjustment = self[keyPath: keyPath] + newDelta
    update(adjustment, in: range, keyPath: keyPath)
  }

  //  public mutating func advancePhaseRadians(by delta: T) {
  //    phaseRadians = Self.wrapToTwoPi(phaseRadians + delta)
  //  }
  //
  //  public mutating func advanceUnitPhase(by du: T) {
  //    let newUnit = Self.wrapUnit(unitPhase + du)
  //    phaseRadians = Self.unitToRadians(newUnit)
  //  }
}

extension Wave {

  /// in day-to-day code, if you store turns, you often don’t need omega at all:
  ///   -  `θ = 2π * (f * t + phaseTurns)`
  ///   -  rather than `θ = ωt + φRadians`
  ///
  ///   Both are correct; the first keeps your stored values human-scale.
  public var omega: T { frequency.omega }

  //  public static var example01: Self {
  //    .init(
  //      amp: 8,
  //      freq: 3,
  //      phase: 0,
  //      waveform: .sine
  //    )
  //  }
  //
  //  public static var example02: Self {
  //    .init(
  //      amp: 60,
  //      freq: 0.1,
  //      phase: 0,
  //      waveform: .sine
  //    )
  //  }
}
