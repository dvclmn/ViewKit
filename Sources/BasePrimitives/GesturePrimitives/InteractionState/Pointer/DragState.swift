//
//  DragState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/3/2026.
//

import Foundation

public struct DragState: PhasicTransientInteraction {

  public var value: CGRect?
  public var phase: InteractionPhase

  public let dragThreshold: CGFloat = 6

  public init(_ value: Value?, phase: InteractionPhase = .none) {
    self.value = value
    self.phase = phase
  }
}
