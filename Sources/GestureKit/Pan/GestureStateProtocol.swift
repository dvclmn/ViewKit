//
//  GestureStateProtocol.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

public protocol GestureStateProtocol {
  associatedtype Value
  var value: Value { get }
  var phase: Interaction.Phase { get }
  
  static var initial: Self { get }
  func withPhase(_ newPhase: Interaction.Phase) -> Self
  var isActive: Bool { get }
//  func clamped(to range: ClosedRange<Value>) -> Self
}

extension GestureStateProtocol {
  public var isActive: Bool { phase.isInteractive }
//  func withPhase(_ phase: GesturePhase) -> Self {
//    Self(offset: offset, phase: phase)
//  }
}
