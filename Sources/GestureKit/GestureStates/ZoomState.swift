//
//  ZoomState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import CoreTools
import Foundation


public struct MagnificationStream {
  var current: CGFloat = 1
  var phase: InteractionPhase = .none
  
  public init(_ current: CGFloat, phase: InteractionPhase) {
    self.current = current
    self.phase = phase
  }
}

extension MagnificationStream {
  public func interaction(previous: CGFloat) -> TransformInteraction? {
    guard phase == .changed else { return nil }
    return .zoom(delta: current - previous)
  }
}
