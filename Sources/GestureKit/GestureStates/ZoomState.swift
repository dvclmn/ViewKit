//
//  ZoomState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import CoreTools
import Foundation

public struct ZoomState {
  private(set) var current: CGFloat
  private(set) var phase: InteractionPhase

  public static var `default`: Self { .init() }

  public init(
    _ current: CGFloat = 1.0,
    phase: InteractionPhase = .none
  ) {
    self.current = current
    self.phase = phase
  }
}

extension ZoomState {

  public mutating func withPhase(_ phase: InteractionPhase) {
    self.phase = phase
  }

  public func zoom(clampedTo range: ClosedRange<CGFloat>) -> CGFloat {
    current.clamped(to: range)
  }

  public mutating func update(_ level: CGFloat, phase: InteractionPhase) {
    self.current = level
    self.phase = phase
  }

}
