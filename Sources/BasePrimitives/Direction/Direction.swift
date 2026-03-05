//
//  Direction.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/7/2025.
//

import SwiftUI

/// This type assumes a top-left origin
public enum Direction: String, CaseIterable, Identifiable {
  case up
  case down
  case left
  case right
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

  public var isHorizontal: Bool {
    switch self {
      case .left, .right: true
      default: false
    }
  }

  public var isVertical: Bool {
    switch self {
      case .up, .down: true
      default: false
    }
  }

  public func update<T: BinaryFloatingPoint>(_ value: inout T, by delta: T) {
    value += T(scalar) * delta
  }

  /// A generic method to mutate a scalar
  public func apply(to value: Int, by delta: Int = 1) -> Int {
    value + scalar * delta
  }

  public func apply<T: BinaryFloatingPoint>(to value: T, by delta: T) -> T {
    value + T(scalar) * delta
  }

  public var toAxis: Axis {
    isVertical ? .vertical : .horizontal
  }

  /// A helper to apply direction to a tuple (for 2D scenarios)
  public func offset(x: Int, y: Int, by delta: Int = 1) -> (x: Int, y: Int) {
    switch toAxis {
      case .vertical:
        return (x, y + scalar * delta)
      case .horizontal:
        return (x + scalar * delta, y)
    }
  }

  /// A helper to apply direction to a tuple of CGFloats (for 2D scenarios in layout/geometry)
  public func offset(
    x: CGFloat,
    y: CGFloat,
    by delta: CGFloat = 1
  ) -> (x: CGFloat, y: CGFloat) {
    switch toAxis {
      case .vertical:
        return (x, y + CGFloat(scalar) * delta)
      case .horizontal:
        return (x + CGFloat(scalar) * delta, y)
    }
  }

  /// Advance a single coordinate along this direction's axis by `delta`.
  /// If the axis doesn't match (e.g., advancing x on a vertical direction), the value is returned unchanged.
  public func advance(x: Int, by delta: Int = 1) -> Int {
    guard toAxis == .horizontal else { return x }
    return x + scalar * delta
  }

  public func advance(y: Int, by delta: Int = 1) -> Int {
    guard toAxis == .vertical else { return y }
    return y + scalar * delta
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

extension Direction {
  public var isUp: Bool { self == .up }
  public var isDown: Bool { self == .down }
  public var isLeft: Bool { self == .left }
  public var isRight: Bool { self == .right }
}
