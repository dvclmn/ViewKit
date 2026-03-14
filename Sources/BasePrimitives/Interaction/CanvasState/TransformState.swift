//
//  CanvasTransformState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 1/3/2026.
//

import SwiftUI

public struct TransformState: Sendable, Equatable {
  /// These always exist, they just return to an identity value when inactive.
  public var pan: ContinuousInteraction<CGSize> = .init(.zero)
  public var zoom: ContinuousInteraction<CGFloat> = .init(1.0)
  public var rotation: ContinuousInteraction<Angle> = .init(.zero)

  public var latchedZoomFocusGlobal: CGPoint?

  public init() {}
}

extension TransformState {
  public static let initial = TransformState()

  public mutating func reset() {
    pan = .init(.zero)
    zoom = .init(1.0)
    rotation = .init(.zero)
  }
}
