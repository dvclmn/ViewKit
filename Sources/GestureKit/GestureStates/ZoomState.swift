//
//  ZoomState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import CoreTools
import Foundation

public struct ZoomStream {
  var current: CGFloat
  var phase: InteractionPhase

  public static var `default`: Self { .init() }

  public init(
    _ current: CGFloat = 1.0,
    phase: InteractionPhase = .none
  ) {
    self.current = current
    self.phase = phase
  }
}

extension ZoomStream {
  
  public var zoom: CGFloat {
    precondition(current.isGreaterThanZero, "Zoom must be greater than zero.")
    return current
  }
  
  public mutating func update(_ level: CGFloat, phase: InteractionPhase) {
    self.current = level
//    translation.width += delta.width
//    translation.height += delta.height
    self.phase = phase
  }
  
  public func interaction(previous: CGFloat) -> TransformInteraction? {
    guard phase == .changed else { return nil }
    return .zoom(delta: current - previous)
  }
  
}
