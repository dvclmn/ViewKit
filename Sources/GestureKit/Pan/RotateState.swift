//
//  RotateState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import SwiftUI

public struct RotateState: GestureStateProtocol, Sendable {
  public let value: Angle
//  let zoom: CGFloat
  public let phase: Interaction.Phase
  
  public static let initial: Self = .init()
  
  public init(
    rotation: Angle = .zero,
    phase: Interaction.Phase = .none
  ) {
    self.value = rotation
    self.phase = phase
    //    self.zoomRange = range
  }
}

extension RotateState {
  public func withPhase(_ newPhase: Interaction.Phase) -> Self {
    Self(rotation: value, phase: newPhase)
  }
}
