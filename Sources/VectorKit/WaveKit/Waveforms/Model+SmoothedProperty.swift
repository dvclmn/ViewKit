//
//  Model+SmoothedProperty.swift
//  AnimationVisualiser
//
//  Created by Dave Coleman on 19/8/2025.
//

import CoreTools
import Foundation

public struct SmoothedProperty: Sendable, Hashable {
  public var target: Double
  public var displayed: Double

  public init(_ initial: Double) {
    self.target = initial
    self.displayed = initial
  }
}

extension SmoothedProperty {

  public mutating func setTarget(_ newValue: Double) {
    self.target = newValue
  }

  public mutating func snapToValue(_ newValue: Double) {
    self.update(dt: 0, smoothing: 0)
  }

  public mutating func update(
    dt: CGFloat,
    smoothing timeConstant: Double
  ) {
    let current = displayed
    displayed = current.smoothed(
      towards: target,
      dt: dt,
      timeConstant: timeConstant
    )
  }
}

extension Array where Element == SmoothedProperty {
  public mutating func updateAll(
    dt: CGFloat,
    timeConstant: CGFloat,
    smoothing: CGFloat
  ) {
    for index in self.indices {
      self[safe: index]?.update(
        dt: timeConstant,
        smoothing: smoothing
      )
    }
  }
}
