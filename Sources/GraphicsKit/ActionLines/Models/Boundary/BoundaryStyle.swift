//
//  ActionLineShape.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 23/1/2026.
//

import CasePaths
// import ColourKit
import CoreGraphics
import CoreTools
import SwiftUI

/// Ideas for future properties:
/// - capStyle
extension ActionLine {

  public struct BoundaryStyle: Equatable, Sendable, Codable {

    public var radius: Double
    public var radiusRange: ClosedRange<Double>
    public var position: CGPoint

    /// A randomised value controlling visual 'rag' quality,
    /// for boundary action line edges?
    public var variation: Double
    public var colour: RGBColour
//    public var colour: HSVColour
    public var shape: BoundaryShape

    public init(
      radius: Double = 0.5,
      radiusRange: ClosedRange<Double> = 0.01...4,
      position: CGPoint = .zero,
      variation: Double = 1,
      colour: RGBColour = .gray(0.5),
      shape: BoundaryShape = .circle
    ) {
      self.radius = radius
      self.radiusRange = radiusRange
      self.position = position
      self.variation = variation
      self.colour = colour
      self.shape = shape
    }
  }
}

extension ActionLine {
  @CaseDetection
  public enum BoundaryKind: String, CaseIterable, Identifiable, NamedItem {
    case inner
    case outer

    public var id: String { rawValue }
    public var name: String { rawValue.capitalized }

//    public var path: WritableKeyPath<ActionLine.Configuration, BoundaryStyle> {
//      switch self {
//        case .inner: \.innerShape
//        case .outer: \.outerShape
//      }
//    }
  }
}
