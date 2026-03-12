//
//  PointerAction.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/1/2026.
//

import Foundation

public struct TrackedInteraction<Value: Sendable & Equatable>: Equatable, Sendable {
  public var value: Value
  public var phase: InteractionPhase
  
  public var isActive: Bool { phase != .none && phase != .cancelled && phase != .ended }
  
  public mutating func update(value: Value, phase: InteractionPhase) {
    self.value = value
    self.phase = phase
  }
}

// Usage:
public struct TransformState: Sendable, Equatable {
  public var pan: TrackedInteraction<CGSize> = .init(value: .zero, phase: .none)
  public var zoom: TrackedInteraction<CGFloat> = .init(value: 1.0, phase: .none)
}



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
