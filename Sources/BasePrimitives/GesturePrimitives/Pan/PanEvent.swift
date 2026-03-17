//
//  PanEvent.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/3/2026.
//

/// Note: This size comes as deltas, which will need to be accrued
/// Modifiers == 'modifiers held'
public typealias SwipeOutput = (SwipeEvent) -> Void

public struct SwipeEvent {
  public let delta: Size<ScreenSpace>
  public let location: Point<ScreenSpace>
  public let phase: InteractionPhase
  public let modifiers: Modifiers
}

extension SwipeEvent {
  public var interaction: Interaction {
    .init(
      kind: .swiping(delta: delta, location: location),
      phase: phase,
      modifiers: modifiers
    )
  }
}
