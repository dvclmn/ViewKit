//
//  GridGeometry.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/2/2026.
//

import CoreGraphics
import SwiftUI

/// Continuous/discrete geometry for grid documents.
public struct GridGeometry: Sendable, Equatable {
  public var viewportRect: CGRect

  public var dimensions: GridDimensions
  public var projection: GridProjection

  /// What is the canvas/artwork's anchor in the parent view
  public var anchor: UnitPoint

  public init(
    viewportRect: CGRect = .zero,
    dimensions: GridDimensions,
    projection: GridProjection,
    anchor: UnitPoint = .center
  ) {
    self.viewportRect = viewportRect
    self.dimensions = dimensions
    self.projection = projection
    self.anchor = anchor
  }
}

extension GridGeometry: ViewportGeometric {
  public var canvasSize: Size<CanvasSpace> {
    projection.canvasSize(for: dimensions)
  }
}

extension GridGeometry {

  public init(
    viewportRect: CGRect = .zero,
    dimensions: GridDimensions,
    unitSize: CGSize,
    rounding: GridRounding = .down,
    anchor: UnitPoint = .center
  ) {
    self.viewportRect = viewportRect
    self.dimensions = dimensions
    self.projection = GridProjection(
      unitSize: unitSize,
      rounding: rounding
    )
    self.anchor = anchor
  }
}

extension GridGeometry: CustomStringConvertible {
  public var description: String {
//    Displstrin
    ""
  }
}
