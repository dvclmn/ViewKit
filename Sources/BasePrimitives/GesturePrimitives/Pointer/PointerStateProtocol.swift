//
//  PointerAction.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/1/2026.
//

import Foundation

public protocol InteractionStateProtocol: Sendable, Equatable {
  /// E.g. CGRect for Drag
  associatedtype Value
  var value: Value? { get set }
  var isActive: Bool { get }

  init(_ value: Value?)

  mutating func update(_ newValue: Value?)
}

extension InteractionStateProtocol {
  public mutating func update(_ newValue: Value?) {
    self.value = newValue
  }

  public var isActive: Bool { value != nil }
}

public protocol PhasicInteractionProtocol: InteractionStateProtocol {
  var phase: InteractionPhase { get set }
  static var initialValue: Value { get }

  init(_ value: Value, phase: InteractionPhase)

  mutating func update(_ newValue: Value, phase: InteractionPhase)
  mutating func updatePhase(_ phase: InteractionPhase)

}

extension PhasicInteractionProtocol {

  public static var initial: Self {
    .init(Self.initialValue, phase: .none)
  }

  public mutating func update(_ newValue: Value, phase: InteractionPhase) {
    self.value = newValue
    self.phase = phase
  }

  public mutating func updatePhase(_ phase: InteractionPhase) {
    self.phase = phase
  }
}

public protocol DeltaInteractionProtocol: InteractionStateProtocol {

}


extension DeltaInteractionProtocol where Value == CGSize {
  public mutating func updateDelta(_ delta: Value) {
    accumulate(delta)
  }
}

extension DeltaInteractionProtocol where Self: PhasicInteractionProtocol, Value == CGSize {
  public mutating func updateDelta(_ delta: Value, phase: InteractionPhase) {
    accumulate(delta)
    self.phase = phase
  }
}

// MARK: - Common delta helper
extension DeltaInteractionProtocol where Value == CGSize {
  @inline(__always)
  fileprivate mutating func accumulate(_ delta: Value) {
    self.value = (self.value ?? .zero) + delta
  }
}


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
