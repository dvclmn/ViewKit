//
//  ContinuousInteraction.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 11/3/2026.
//


// MARK: - Continuous
/// Value-based: value is always present; define a default
/// E.g. Pan, zoom
public protocol ContinuousInteraction: InteractionState {
  associatedtype Value
  var value: Value { get set }
  static var initialValue: Value { get }
  init(_ value: Value)
}

extension ContinuousInteraction {
  public init(_ value: Value) { self.init(value) }
  public mutating func update(_ newValue: Value) { value = newValue }
  
  /// If type is phasic, can override with a phase-based rule
  public var isActive: Bool { true }
  
  public static var initial: Self { .init(Self.initialValue) }
}
