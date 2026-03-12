//
//  PhasicContinuous.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/3/2026.
//

public protocol PhasicContinuousInteraction: PhasicInteraction, ContinuousInteraction {
  var phase: InteractionPhase { get set }
  init(_ value: Value, phase: InteractionPhase)
  mutating func update(_ newValue: Value, phase: InteractionPhase)
  mutating func updatePhase(_ phase: InteractionPhase)
}

extension PhasicContinuousInteraction {
  public mutating func update(_ newValue: Value, phase: InteractionPhase) {
    value = newValue
    self.phase = phase
  }
  public mutating func updatePhase(_ phase: InteractionPhase) {
    self.phase = phase
  }
  public var isActive: Bool {
    /// Defaulted (aka `initialValue`) states can be considered active only during a phase
    phase != .none
  }

  public mutating func reset() { self = Self.initial }

  public static var initial: Self { .init(Self.initialValue, phase: .none) }
}
