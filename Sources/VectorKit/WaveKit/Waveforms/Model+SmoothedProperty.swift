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
    self.target = newValue
  }

  public mutating func snapToValue(_ newValue: T) {
    self.update(dt: 0, smoothing: 0)
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

extension Array where Element == Smoothed {
  public mutating func updateAll(
    dt: T,
    timeConstant: T,
    smoothing: T
  ) {
    for index in self.indices {
      self[safe: index]?.update(
        dt: timeConstant,
        smoothing: smoothing
      )
    }
  }
}
