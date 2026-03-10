//
//  PhasicInteraction.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/3/2026.
//

import Foundation

public protocol PhasicTransientInteraction: TransientInteraction {
  var phase: InteractionPhase { get set }

  init(_ value: Value?, phase: InteractionPhase)

  mutating func update(_ newValue: Value, phase: InteractionPhase)
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

public protocol PhasicContinuousInteraction: ContinuousInteraction {
  var phase: InteractionPhase { get set }
  init(_ value: Value, phase: InteractionPhase)
  mutating func update(_ newValue: Value, phase: InteractionPhase)
  mutating func updatePhase(_ phase: InteractionPhase)
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
//extension PhasicDefaultedInteraction {
//  public mutating func update(_ newValue: Value, phase: InteractionPhase) {
//    value = newValue
//    self.phase = phase
//  }
//  public mutating func updatePhase(_ phase: InteractionPhase) {
//    self.phase = phase
//  }
//  public var isActive: Bool {
//    // Defaulted states can be considered active only during a phase,
//    // which avoids "always true" if that’s what you want.
//    phase != .none
//  }
//}
