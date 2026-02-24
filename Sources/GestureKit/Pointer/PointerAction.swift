//
//  PointerAction.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/1/2026.
//

public protocol PointerAction: Sendable {
  
  /// E.g. CGRect for Drag
  associatedtype Value
  
  var value: Value? { get set }
  
  /// Not relevant for Tap, only Drag and Hover
  var isActive: Bool { get set }
  
  init(_ value: Value?)
  mutating func update(_ newValue: Value?, isActive: Bool)
  
  /// A value for 'at rest'
//  static var initialValue: Value { get }
  
//  mutating func update(_ newValue: Value, phase: InteractionPhase)
//  mutating func updatePhase(_ phase: InteractionPhase)
}

extension PointerAction {
  public mutating func update(_ newValue: Value?, isActive: Bool) {
    self.value = newValue
    self.isActive = isActive
  }
}
