//
//  DeltaInteraction.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 10/3/2026.
//

import Foundation

public protocol DeltaInteraction: InteractionState {}

extension DeltaInteraction where Self: ContinuousInteraction, Value == CGSize {
  public mutating func updateDelta(_ delta: Value) {
    self.value += delta
  }
}

extension DeltaInteraction where Self: PhasicContinuousInteraction, Value == CGSize {
  public mutating func updateDelta(_ delta: Value, phase: InteractionPhase) {
    self.value += delta
    self.phase = phase
  }
}
