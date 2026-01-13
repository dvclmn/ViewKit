//
//  RotateState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import SwiftUI
import CoreTools

public struct RotateState: Sendable {
  public let value: Angle
  private(set) var phase: InteractionPhase
  
  public static let initial: Self = .init()
  
  public init(
    _ rotation: Angle = .zero,
    phase: InteractionPhase = .none
  ) {
    self.value = rotation
     self.phase = phase
  }
}

extension RotateState {
//  public func withPhase(_ newPhase: Interaction.Phase) -> Self {
//    Self(rotation: value, phase: newPhase)
//  }
}
