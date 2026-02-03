//
//  Model+SmoothedProperty.swift
//  AnimationVisualiser
//
//  Created by Dave Coleman on 19/8/2025.
//

import CoreTools
import Foundation

public typealias SmoothedFloat = Smoothed<Double>
//public typealias SmoothedFloat = Smoothed<Float>

/// These just never seem to work — like ``ContinuousParameter``
/// Filtering (low‑pass) of any scalar input.
/// Domain‑agnostic (works for amplitude, frequency, noise, etc.).
public struct Smoothed<T: WaveFloat>: Hashable {
  public var target: T
  public var displayed: T

  public init(_ initial: T) {
    self.target = initial
    self.displayed = initial
  }
}

extension Smoothed {

  public mutating func setTarget(_ newValue: T) {
    target = newValue
  }

  public mutating func snapToValue(_ newValue: T) {
    target = newValue
    displayed = newValue
  }

  public mutating func update(
    dt: T,
    smoothing timeConstant: T
  ) {
    let current = displayed
    displayed = current.smoothed(
      towards: target,
      dt: dt,
      timeConstant: timeConstant
    )
  }
}

extension Array {
  public mutating func updateAll<T: BinaryFloatingPoint>(
    dt: T,
    smoothing timeConstant: T,
  ) where Element == Smoothed<T> {
    for index in self.indices {
      self[safe: index]?.update(dt: dt, smoothing: timeConstant)
    }
  }
}

extension BinaryFloatingPoint {

  /// Smoothly approaches `target` using exponential smoothing
  /// - Parameters:
  ///   - target: The target value to approach
  ///   - dt: Time since last update (seconds)
  ///   - timeConstant: Smoothing time constant τ (seconds) - time to reach ~63% of target
  /// - Returns: Updated value
  ///
  /// Notes:
  /// `timeConstant` controls how quickly the smoothing converges toward the target value
  ///
  /// Read more in Bear:
  /// bear://x-callback-url/open-note?id=65D4914D-3835-4F79-B8D0-4820B68B7F1B
  public func smoothed(
    towards target: Self,
    dt: Self,
    timeConstant: Self
  ) -> Self {
    /// Snap on first frame, or if timeConstant is too small
    /// Very small time constants would cause erratic behavior
    guard dt > 0 else { return target }
    guard timeConstant > 0.001 else { return target }

    /// Calculate the ratio of elapsed time to time constant
    /// This determines how much "decay" should occur
    let timeRatio = dt / timeConstant

    /// Calculate exponential decay factor
    /// exp(-timeRatio) represents how much of the OLD value to retain
    /// When timeRatio is small (`dt << τ`), decay ≈ 1 (keep most of old value)
    /// When timeRatio is large (`dt >> τ`), decay ≈ 0 (discard old value)
    let exponentialDecay = Self(exp(Double(-timeRatio)))

    /// Calculate the smoothing factor (learning rate)
    /// This represents how much to move toward the target
    /// alpha = 0 means no movement, alpha = 1 means jump directly to target
    let alpha = 1 - exponentialDecay

    /// Interpolate between current value and target
    /// `self + (target - self) * alpha` is equivalent to:
    /// `self * (1 - alpha) + target * alpha`
    let difference = target - self
    let adjustment = difference * alpha

    return self + adjustment
  }

}
