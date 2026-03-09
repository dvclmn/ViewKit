//
//  RotateState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import SwiftUI

public struct RotateState: TransformAction {
  public static var initialValue: Angle { .zero }
  public var value: Angle
  public var phase: InteractionPhase

  public init(
    _ value: Angle = .zero,
    phase: InteractionPhase = .none
  ) {
    self.value = value
    self.phase = phase
  }
}

extension RotateState {
  public var rotation: Angle { value }
}
