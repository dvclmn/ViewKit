//
//  Point.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/3/2026.
//

import Foundation

public struct Point<Space>: Sendable {
  public var x: CGFloat
  public var y: CGFloat

  public init(x: CGFloat, y: CGFloat) {
    self.x = x
    self.y = y
  }

  public init(fromPoint point: CGPoint) {
    self.x = point.x
    self.y = point.y
  }

  public init(fromOffset point: CGSize) {
    self.x = point.width
    self.y = point.height
  }
}
