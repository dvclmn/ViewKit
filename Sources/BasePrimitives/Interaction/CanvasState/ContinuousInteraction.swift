//
//  ContinuousInteraction.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/3/2026.
//

import Foundation

public struct ContinuousInteraction<Value: Sendable & Equatable>: Equatable, Sendable {
  public var value: Value
  public var phase: InteractionPhase

  public var isActive: Bool {
    phase != .none
      && phase != .cancelled
      && phase != .ended
  }

  public init(_ value: Value, phase: InteractionPhase = .none) {
    self.value = value
    self.phase = phase
  }

  public mutating func update(_ value: Value, phase: InteractionPhase) {
    self.value = value
    self.phase = phase
  }

}
