//
//  TransientInteraction.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/3/2026.
//

// MARK: - Transient
/// Presence-based: value is optional, nil means "no interaction"
/// E.g. Hover, Tap
public protocol TransientInteraction: InteractionState {
  associatedtype Value
  var value: Value? { get set }
}

extension TransientInteraction {
  
  public var isActive: Bool { value != nil }
  public mutating func update(_ newValue: Value?) { value = newValue }
  public mutating func reset() { self.value = nil }
  
  //  public static var initial: Self { .init(nil) }
}
