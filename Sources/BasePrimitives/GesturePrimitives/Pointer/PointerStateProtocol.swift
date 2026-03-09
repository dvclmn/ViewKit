//
//  PointerAction.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 15/1/2026.
//

public protocol PointerStateProtocol: Sendable, Equatable {
  /// E.g. CGRect for Drag
  associatedtype Value
  var value: Value? { get set }
  init(_ value: Value?)
  mutating func update(_ newValue: Value?)
}

extension PointerStateProtocol {
  public mutating func update(_ newValue: Value?) {
    self.value = newValue
  }
}

// MARK: - Activatable
public protocol Activatable {
  var isActive: Bool { get set }
}

extension PointerStateProtocol where Self: Activatable {
  public mutating func update(_ newValue: Value?, isActive: Bool) {
    self.value = newValue
    self.isActive = isActive
  }
}
