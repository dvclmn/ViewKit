//
//  GridDragEvent.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/3/2026.
//

import Foundation

public struct GridDragEvent {
  public let start: GridPosition
  public let end: GridPosition
  public let phase: InteractionPhase

  public init(start: GridPosition, end: GridPosition, phase: InteractionPhase) {
    self.start = start
    self.end = end
    self.phase = phase
  }
}
