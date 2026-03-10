//
//  DragBehaviour.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 14/1/2026.
//

import SwiftUI

public enum DragBehavior: Equatable, Sendable {
  /// Transient rectangle from drag origin to current point
  case marquee(drawMarquee: Bool)

  /// Accumulated offset that persists across drags
  case continuous(axes: GridAxis.Set = .all)

  /// Gesture is not active
  case none

  public static var marquee: Self { .marquee(drawMarquee: true) }
  public static var continuous: Self { .continuous() }

  public var axes: GridAxis.Set {
    if case .continuous(let axes) = self {
      return axes
    }
    return .all
  }
}

extension DragBehavior {

  public var isMarquee: Bool {
    if case .marquee(let drawMarquee) = self {
      return drawMarquee
    }
    return false
  }

  public var isEnabled: Bool { self != .none }
}
