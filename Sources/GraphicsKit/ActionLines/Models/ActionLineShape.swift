//
//  ActionLineShape.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/1/2026.
//

import Foundation

public struct ActionLineShape {
  public var radius: Double
  public var position: CGPoint?
  public var variation: Double
  /// Future properties:
  // var capStyle: CapStyle
  // var thickness: Double
  
  public init(
    radius: Double,
    position: CGPoint? = nil,
    variation: Double = 0
  ) {
    self.radius = radius
    self.position = position
    self.variation = variation
  }
}
