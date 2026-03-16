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
//  public var source: InteractionSource

  public var isActive: Bool { phase.isActive }

}

extension ContinuousInteraction {

  public init(
    _ value: Value,
    phase: InteractionPhase = .none,
//    source: InteractionSource,
  ) {
    self.value = value
    self.phase = phase
//    self.source = source
  }

  public mutating func update(
    _ value: Value,
    phase: InteractionPhase,
//    source: InteractionSource,
  ) {
    self.value = value
    self.phase = phase
//    self.source = source
  }

}
