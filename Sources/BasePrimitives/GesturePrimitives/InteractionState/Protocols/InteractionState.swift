//
//  PointerAction.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/1/2026.
//

import Foundation

public protocol InteractionState: Sendable, Equatable {
  associatedtype Value
  var isActive: Bool { get }
}

// MARK: - Phase-based Interaction
public protocol PhasicInteraction: InteractionState {
  var phase: InteractionPhase { get set }
}

// MARK: - Delta-based Interaction
public protocol DeltaInteraction: InteractionState {}

extension DeltaInteraction where Self: ContinuousInteraction, Value == CGSize {
  public mutating func updateDelta(_ delta: Value) {
    self.value += delta
  }
}

// MARK: - Delta *and* Phase -based Interaction
extension DeltaInteraction where Self: PhasicContinuousInteraction, Value == CGSize {
  public mutating func updateDelta(_ delta: Value, phase: InteractionPhase) {
    self.value += delta
    self.phase = phase
  }
}
