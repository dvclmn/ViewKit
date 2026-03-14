//
//  TransientInteraction.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/3/2026.
//

import Foundation

public struct TransientInteraction<Value: Sendable & Equatable>: Sendable, Equatable {
  public var value: Value?
  public var phase: InteractionPhase

  /// It's active if we have data AND the phase hasn't terminated.
  public var isActive: Bool {
    value != nil
      && phase != .none
      && phase != .cancelled
      && phase != .ended
  }

  public init(_ value: Value? = nil, phase: InteractionPhase = .none) {
    self.value = value
    self.phase = phase
  }

  public mutating func update(_ value: Value?, phase: InteractionPhase) {
    self.value = value
    self.phase = phase
  }

  /// Instantly clears the transient state.
  public mutating func reset() {
    self.value = nil
    self.phase = .none
  }
}
