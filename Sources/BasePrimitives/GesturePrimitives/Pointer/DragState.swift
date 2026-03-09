//
//  DragState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/3/2026.
//

import Foundation

public struct DragState: PointerStateProtocol {
  public var value: CGRect?
  public var phase: InteractionPhase

  public let dragThreshold: CGFloat = 6

  public init(_ value: Value? = nil) {
    self.value = value
    self.phase = .none
  }

  public init(
    _ value: Value? = nil,
    phase: InteractionPhase = .none
  ) {
    self.value = value
    self.phase = phase
  }
}
