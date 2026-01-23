//
//  ActionLineShape.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/1/2026.
//

import Foundation
import CoreGraphics

extension ActionLine {

  public struct Shape: Equatable {

    public var radius: Double
    public var position: CGPoint

    /// A randomised value controlling visual 'rag' quality,
    /// for boundary action line edges?
    public var variation: Double
    public var shape: BoundaryShape
    /// Future properties:
    // var capStyle: CapStyle
    // var thickness: Double

    public init(
      radius: Double,
      position: CGPoint = .zero,
      variation: Double = 1,
      shape: BoundaryShape = .circle
    ) {
      self.radius = radius
      self.position = position
      self.variation = variation
      self.shape = shape
    }
  }

}

extension ActionLine {
  public enum BoundaryKind: String {
    case inner
    case outer
  }
}

extension ActionLine.BoundaryKind {
  public var name: String { rawValue.capitalized }
}
