//
//  PhasicTransient.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/3/2026.
//

//public protocol PhasicTransientInteraction: PhasicInteraction, TransientInteraction {
//  var phase: InteractionPhase { get set }
//
//  init(_ value: Value?, phase: InteractionPhase)
//
//  mutating func update(_ newValue: Value?, phase: InteractionPhase)
//  mutating func updatePhase(_ phase: InteractionPhase)
//
//}
//
//extension PhasicTransientInteraction {
//  public mutating func update(_ newValue: Value?, phase: InteractionPhase) {
//    value = newValue
//    self.phase = phase
//  }
//  public mutating func updatePhase(_ phase: InteractionPhase) {
//    self.phase = phase
//  }
//
//  public mutating func reset() {
//    self.value = nil
//    self.phase = .none
//  }
//  
//  public var isActive: Bool { value != nil || phase != .none }
//}
