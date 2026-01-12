//
//  ZoomState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 9/1/2026.
//

import CoreTools
import Foundation

struct PanGestureStream {
  var translation: CGSize
  var phase: InteractionPhase
}

struct MagnificationStream {
  var current: CGFloat = 1
  var phase: InteractionPhase = .none
}

extension MagnificationStream {
  func interaction(previous: CGFloat) -> TransformInteraction? {
    guard phase == .changed else { return nil }
    return .zoom(delta: current - previous)
  }
}

//public struct ZoomState: Sendable {
//  public let value: CGFloat
//
//  public static let initial: Self = .init()
//
//  public init(
//    zoom: CGFloat = 1.0,
//  ) {
//    self.value = zoom
//  }
//}
//
//extension ZoomState {
//
//  var zoom: CGFloat { value }
//
//
//
//
//
//  //  public func withPhase(_ newPhase: Interaction.Phase) -> Self {
//  //    Self(zoom: value, phase: newPhase)
//  //  }
//
//
//
//}
