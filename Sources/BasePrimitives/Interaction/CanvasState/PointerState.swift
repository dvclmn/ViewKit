//
//  PointerState.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 7/3/2026.
//

import CoreGraphics
import Foundation

public struct PointerState: Sendable, Equatable {
  public var tap: TransientInteraction<Point<ScreenSpace>> = .init()
  public var hover: TransientInteraction<Point<ScreenSpace>> = .init()
  public var drag: TransientInteraction<Rect<ScreenSpace>> = .init()

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
