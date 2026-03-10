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
  var isActive: Bool { get }
}

extension PointerStateProtocol {
  public mutating func update(_ newValue: Value?) {
    self.value = newValue
  }
  
  public var isActive: Bool { value != nil }
}


