//
//  PointerAction.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/1/2026.
//

public protocol Activatable {
  var isActive: Bool { get set }
}

public protocol PointerAction: Sendable {

  /// E.g. CGRect for Drag
  associatedtype Value

  var value: Value? { get set }

  init(_ value: Value?)
  mutating func update(_ newValue: Value?)

  /// A value for 'at rest'
  //  static var initialValue: Value { get }

  //  mutating func update(_ newValue: Value, phase: InteractionPhase)
  //  mutating func updatePhase(_ phase: InteractionPhase)
}

extension PointerAction {

    public mutating func update(_ newValue: Value?) {
      self.value = newValue
  //    self.isActive = isActive
    }
}

extension PointerAction where Self: Activatable {
  public mutating func update(_ newValue: Value?, isActive: Bool) {
    self.value = newValue
    self.isActive = isActive
  }
}
