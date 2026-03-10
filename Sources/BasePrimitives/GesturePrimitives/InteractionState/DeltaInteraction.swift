//
//  DeltaInteraction.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/3/2026.
//

import Foundation

public protocol DeltaInteraction: InteractionState {}

//extension DeltaInteraction {
//  public var startValue: Value? {
//    self.value ?? Self.initialValue
//  }
//}

extension DeltaInteraction where Self: TransientPhasicInteraction, Value == CGSize {
  public mutating func updateDelta(_ delta: Value) {
    accumulate(delta)
  }
}

extension DeltaInteraction where Self: Phasic, Value == CGSize {
  public mutating func updateDelta(_ delta: Value, phase: InteractionPhase) {
    accumulate(delta)
    self.phase = phase
  }
}

// MARK: - Common delta helper
extension DeltaInteraction where Value == CGSize {
  @inline(__always)
  fileprivate mutating func accumulate(_ delta: Value) {
    self.value = (self.startValue ?? .zero) + delta
  }
}

//extension DeltaInteraction where Self: OptionalInteractionState, Value == CGSize {
//  public var startValue: Value { value ?? .zero }
//  public mutating func updateDelta(_ delta: Value) {
//    value = startValue + delta
//  }
//}
//
//extension DeltaInteraction where Self: PhasicOptionalInteraction, Value == CGSize {
//  public mutating func updateDelta(_ delta: Value, phase: InteractionPhase) {
//    value = (value ?? .zero) + delta
//    self.phase = phase
//  }
//}
//
//extension DeltaInteraction where Self: DefaultedInteractionState, Value == CGSize {
//  public mutating func updateDelta(_ delta: Value) {
//    value = value + delta
//  }
//}
//
//extension DeltaInteractionProtocol where Self: PhasicDefaultedInteraction, Value == CGSize {
//  public mutating func updateDelta(_ delta: Value, phase: InteractionPhase) {
//    value = value + delta
//    self.phase = phase
//  }
//}
