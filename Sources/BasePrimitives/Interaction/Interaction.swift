//
//  Interaction.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 16/3/2026.
//

public struct Interaction {
  /// This is like the payload?
  public var kind: InteractionKind
  public var phase: InteractionPhase
  public var modifiers: Modifiers
  
  public init(
    kind: InteractionKind,
    phase: InteractionPhase,
    modifiers: Modifiers
  ) {
    self.kind = kind
    self.phase = phase
    self.modifiers = modifiers
  }
}

