//
//  RotateState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import SwiftUI

public struct RotateState: Sendable {
  public let value: Angle
  
  public static let initial: Self = .init()
  
  public init(rotation: Angle = .zero) {
    self.value = rotation
  }
}

extension RotateState {
//  public func withPhase(_ newPhase: Interaction.Phase) -> Self {
//    Self(rotation: value, phase: newPhase)
//  }
}
