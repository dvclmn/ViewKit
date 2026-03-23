//
//  GridDragEvent.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/3/2026.
//

import Foundation

public struct GridDragEvent {
  public let start: GridPosition
  public let current: GridPosition
  public let phase: InteractionPhase

  public init(
    start: GridPosition,
    current: GridPosition,
    phase: InteractionPhase
  ) {
    self.start = start
    self.current = current
    self.phase = phase
  }
}
