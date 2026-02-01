//
//  Model+SmoothedProperty.swift
//  AnimationVisualiser
//
//  Created by Dave Coleman on 19/8/2025.
//

import CoreTools
import Foundation

/// These just never seem to work — like ``ContinuousParameter``
/// Filtering (low‑pass) of any scalar input.
/// Domain‑agnostic (works for amplitude, frequency, noise, etc.).
public struct Smoothed<T: BinaryFloatingPoint>: Hashable {
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
