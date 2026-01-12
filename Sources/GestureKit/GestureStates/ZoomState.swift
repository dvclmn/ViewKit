//
//  ZoomState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import CoreTools
import Foundation

public struct PanGestureStream {
  var translation: CGSize = .zero
  var phase: InteractionPhase = .none
  
  static var centered: Self { .init(translation: .zero) }
}

public struct MagnificationStream {
  var current: CGFloat = 1
  var phase: InteractionPhase = .none
}

extension MagnificationStream {
  public func interaction(previous: CGFloat) -> TransformInteraction? {
    guard phase == .changed else { return nil }
    return .zoom(delta: current - previous)
  }
}
