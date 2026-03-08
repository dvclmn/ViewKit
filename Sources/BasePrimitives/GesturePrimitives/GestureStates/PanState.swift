//
//  Model+PanPhase.swift
//  LilyPad
//
//  Created by Dave Coleman on 24/6/2025.
//

import CoreGraphics
import Foundation

public struct PanState: CanvasGestureState, ClampedGestureState {
  public static var initialValue: CGSize { .zero }
  public var value: CGSize
  public var phase: InteractionPhase

  public init(
    _ value: CGSize = .zero,
    phase: InteractionPhase = .none
  ) {
    self.value = value
    self.phase = phase
  }
}

extension PanState {
  public static var centered: Self { .init(.zero) }

  public var pan: CGSize { value }
}
