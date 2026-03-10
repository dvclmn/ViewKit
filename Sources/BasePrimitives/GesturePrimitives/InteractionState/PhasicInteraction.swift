//
//  PhasicInteraction.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/3/2026.
//

import Foundation

public protocol PhasicInteraction: InteractionState {
  var phase: InteractionPhase { get set }
//  mutating func update(_ newValue: Value)
}

// MARK: - Transient
public protocol PhasicTransientInteraction: PhasicInteraction, TransientInteraction {
  var phase: InteractionPhase { get set }

  init(_ value: Value?, phase: InteractionPhase)

  mutating func update(_ newValue: Value?, phase: InteractionPhase)
  mutating func updatePhase(_ phase: InteractionPhase)

}

extension PhasicTransientInteraction {
  public mutating func update(_ newValue: Value?, phase: InteractionPhase) {
    value = newValue
    self.phase = phase
  }
  public mutating func updatePhase(_ phase: InteractionPhase) {
    self.phase = phase
  }
  public var isActive: Bool { value != nil || phase != .none }
}

// MARK: - Continuous
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
  
  public static var initial: Self { .init(Self.initialValue, phase: .none) }
}

//extension PhasicInteraction {
//
//  public static var initial: Self? {
//    guard let value = Self.initialValue else { return nil }
//    return .init(value, phase: .none)
//  }
//
//  public mutating func update(_ newValue: Value, phase: InteractionPhase) {
//    self.value = newValue
//    self.phase = phase
//  }
//
//  public mutating func updatePhase(_ phase: InteractionPhase) {
//    self.phase = phase
//  }
//}

// Optional + phase
//public protocol PhasicOptionalInteraction: OptionalInteractionState {
//  var phase: InteractionPhase { get set }
//  init(_ value: Value?, phase: InteractionPhase)
//  mutating func update(_ newValue: Value?, phase: InteractionPhase)
//  mutating func updatePhase(_ phase: InteractionPhase)
//}
//
//extension PhasicOptionalInteraction {
//  public mutating func update(_ newValue: Value?, phase: InteractionPhase) {
//    value = newValue
//    self.phase = phase
//  }
//  public mutating func updatePhase(_ phase: InteractionPhase) {
//    self.phase = phase
//  }
//  public var isActive: Bool {
//    // presence OR non-.none phase can define activity
//    value != nil || phase != .none
//  }
//}
//
//// Defaulted + phase
//public protocol PhasicDefaultedInteraction: DefaultedInteractionState {
//  var phase: InteractionPhase { get set }
//  init(_ value: Value, phase: InteractionPhase)
//  mutating func update(_ newValue: Value, phase: InteractionPhase)
//  mutating func updatePhase(_ phase: InteractionPhase)
//}
//

