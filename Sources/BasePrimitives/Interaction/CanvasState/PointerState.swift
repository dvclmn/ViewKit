//
//  PointerState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/3/2026.
//

import CoreGraphics
import Foundation

public struct PointerState: Sendable, Equatable {
  /// These only exist when they are happening.
  public var tap: TransientInteraction<CGPoint> = .init()
  public var hover: TransientInteraction<CGPoint> = .init()

  /// Drag data usually needs an origin and a translation/current point.
  public var drag: TransientInteraction<CGRect> = .init()

  public let dragThreshold: CGFloat = 6

  public init() {}
}

extension PointerState {
  public static let initial = PointerState()

  public mutating func reset() {
    tap.reset()
    hover.reset()
    drag.reset()
  }
}
