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

/// Presence-based: value is optional, nil means "no interaction"
public protocol TransientInteraction: InteractionState {
  associatedtype Value
  var value: Value? { get set }
  static var initialValue: Value? { get }  // typically nil
  mutating func update(_ newValue: Value?)
}

extension TransientInteraction {
  public static var initialValue: Value? { nil }
  public var isActive: Bool { value != nil }
  public mutating func update(_ newValue: Value?) { value = newValue }
}

/// Value-based: value is always present; define a default
public protocol ContinuousInteraction: InteractionState {
  associatedtype Value
  var value: Value { get set }
  static var defaultValue: Value { get }
  init(_ value: Value)
  mutating func update(_ newValue: Value)
}

extension ContinuousInteraction {
  public init(_ value: Value) { self.init(value) }
  public mutating func update(_ newValue: Value) { value = newValue }

  /// If type is phasic, can override with a phase-based rule
  public var isActive: Bool { true }
}

//public protocol InteractionState: Sendable, Equatable {
//  /// E.g. CGRect for Drag
//  associatedtype Value
//  var isActive: Bool { get }
//}
//
//extension InteractionState {
//  public mutating func update(_ newValue: Value?) {
//    self.value = newValue
//  }
//
//  public static var initialValue: CGPoint? { nil }
//
//  public var isActive: Bool { value != nil }
//}

//extension DeltaInteractionProtocol where Value == CGSize {
//  public mutating func updateDelta(_ delta: Value) {
//    self.value = (self.value ?? .zero) + delta
//  }
//}
//
//extension DeltaInteractionProtocol where Self: PhasicInteractionProtocol, Value == CGSize {
//  public mutating func updateDelta(_ delta: Value, phase: InteractionPhase) {
//    self.value = (self.value ?? .zero) + delta
//    self.phase = phase
//  }
//}

//public protocol PointerStateProtocol: Sendable, Equatable {
//  /// E.g. CGRect for Drag
//  associatedtype Value
//  var value: Value? { get set }
//
//  init(_ value: Value?)
//  mutating func update(_ newValue: Value?)
//  var isActive: Bool { get }
//}
//
//extension PointerStateProtocol {
//  public mutating func update(_ newValue: Value?) {
//    self.value = newValue
//  }
//
//  public var isActive: Bool { value != nil }
//}
