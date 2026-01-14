//
//  Direction.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/7/2025.
//

import EnumMacros
import SwiftUI

@CaseDetection
/// This type assumes a top-left origin
public enum Direction: String, CaseIterable, Identifiable {
  case up
  case down
  case left
  case right
}

extension Direction {
  @CaseDetection
  public enum Vertical {
    case up
    case down

    public var opposite: Self { isUp ? .down : .up }
  }
}

extension Direction {

  public var id: String { rawValue }

  /// +1 or -1 multiplier, for 1D movement
  public var scalar: Int {
    switch self {
      case .up, .left: -1
      case .down, .right: 1
    }
  }

  public var axis: Axis {
    switch self {
      case .up, .down: .vertical
      case .left, .right: .horizontal
    }
  }

  /// A generic method to mutate a scalar
  public func apply(to value: Int, by delta: Int = 1) -> Int {
    value + scalar * delta
  }

  /// A helper to apply direction to a tuple (for 2D scenarios)
  public func offset(x: Int, y: Int, by delta: Int = 1) -> (x: Int, y: Int) {
    switch self {
      case .up: (x, y - delta)
      case .down: (x, y + delta)
      case .left: (x - delta, y)
      case .right: (x + delta, y)
    }
  }

  public var keyEquivalent: KeyEquivalent {
    switch self {
      case .up: .upArrow
      case .down: .downArrow
      case .left: .leftArrow
      case .right: .rightArrow
    }
  }
}
