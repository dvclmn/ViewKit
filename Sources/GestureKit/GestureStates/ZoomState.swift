//
//  ZoomState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import CoreTools
import Foundation

public struct ZoomState: CanvasGestureState {

  public static var initialValue: CGFloat { 1.0 }
  public var value: CGFloat
  public var phase: InteractionPhase

  public init(
    _ value: CGFloat = 1.0,
    phase: InteractionPhase = .none
  ) {
    self.value = value
    self.phase = phase
  }
}

extension ZoomState {

  public func zoom(clampedTo range: ClosedRange<CGFloat>) -> CGFloat {
    value.clamped(to: range)
  }
}
