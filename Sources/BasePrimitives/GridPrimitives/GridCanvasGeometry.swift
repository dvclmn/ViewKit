//
//  GridCanvasGeometry.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 27/2/2026.
//

import CoreGraphics
import SwiftUI

/// Continuous/discrete geometry for grid documents.
public struct GridGeometry: Sendable, Equatable, ViewportGeometric {
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

extension GridGeometry {

  public var canvasSize: Size<CanvasSpace> {
    projection.canvasSize(for: dimensions)
  }

//  public var canvasCGSize: CGSize {
//    projection.canvasCGSize(for: dimensions)
//  }

//  public func viewportContext(
//    zoom: CGFloat,
//    pan: CGSize
//  ) -> ViewportContext {
//    ViewportContext(
//      viewportRect: viewportRect,
//      pan: Point<ScreenSpace>(x: pan.width, y: pan.height),
//      zoom: zoom,
//      canvasSize: canvasSize,
//      canvasAnchor: anchor
//    )
//  }
}
