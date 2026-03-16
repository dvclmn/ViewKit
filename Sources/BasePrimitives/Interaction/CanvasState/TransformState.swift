//
//  CanvasTransformState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/3/2026.
//

import SwiftUI

public struct TransformState: Sendable, Equatable {
  public var translation: ContinuousInteraction<CGSize>
  public var scale: ContinuousInteraction<CGFloat>
  public var rotation: ContinuousInteraction<Angle>

//  public var translation: CGSize
//  public var scale: CGFloat
//  public var rotation: Angle

  public init(
    translation: ContinuousInteraction<CGSize> = .init(.zero),
    scale: ContinuousInteraction<CGFloat> = .init(1.0),
    rotation:  ContinuousInteraction<Angle> = .init(.zero),
  ) {
    self.translation = translation
    self.scale = scale
    self.rotation = rotation
  }

  public var latchedZoomFocusGlobal: CGPoint?

  public static let identity: Self = .init()
}

extension TransformState {
  public static let initial = TransformState()

  public mutating func reset() {
    self = Self.identity
    //    translation = .zero
    //    scale = 1.0
    //    rotation = .zero
    //    pan = .init(.zero)
    //    zoom = .init(1.0)
    //    rotation = .init(.zero)
  }
}
