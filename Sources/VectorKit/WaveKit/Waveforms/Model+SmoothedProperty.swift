//
//  Model+SmoothedProperty.swift
//  AnimationVisualiser
//
//  Created by Dave Coleman on 19/8/2025.
//

import Foundation

public struct SmoothedProperty: Sendable, Hashable {
  public var target: CGFloat
  public var displayed: CGFloat

  public init(_ initial: CGFloat) {
    self.target = initial
    self.displayed = initial
  }
}

extension SmoothedProperty {

  public mutating func setTarget(_ newValue: CGFloat) {
    self.target = newValue
  }

  public mutating func snapUpdate(_ newValue: CGFloat) {
    self.update(dt: 0, smoothing: 0)
  }

  public mutating func update(dt: CGFloat, smoothing timeConstant: CGFloat) {
    let current = displayed
    displayed = current.smoothed(
      towards: target,
      dt: dt,
      timeConstant: timeConstant
    )
  }
}
