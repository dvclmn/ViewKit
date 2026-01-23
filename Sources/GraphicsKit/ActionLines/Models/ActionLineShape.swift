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
  
  /// A randomised value controlling visual 'rag' quality,
  /// for boundary action line edges?
  public var variation: Double
  public var shape: BoundaryShape
  /// Future properties:
  // var capStyle: CapStyle
  // var thickness: Double
  
  public init(
    radius: Double,
    position: CGPoint? = nil,
    variation: Double = 0,
    shape: BoundaryShape = .circle
  ) {
    self.radius = radius
    self.position = position
    self.variation = variation
    self.shape = shape
  }
}
