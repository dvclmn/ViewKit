//
//  ZoomState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import Foundation

public struct ZoomState: PhasicContinuousInteraction {

  public static var initialValue: Double { 1.0 }
  public var value: Double
  public var phase: InteractionPhase

  public init(
    _ value: Double = 1.0,
    phase: InteractionPhase = .none
  ) {
    self.value = value
    self.phase = phase
  }
}

extension ZoomState {
  /// Note: Zoom already clamped at the gesture level
  public func zoom(clampedTo range: ClosedRange<Double>) -> Double {
    value.clamped(to: range)
  }

  public var zoom: Double { value }
}
