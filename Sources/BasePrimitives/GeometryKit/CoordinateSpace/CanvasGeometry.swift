//
//  CanvasGeometry.swift
//  CanvasKit
//
//  Created by Dave Coleman on 9/1/2026.
//

import CoreGraphics
import SwiftUI

public struct CanvasGeometry: Sendable, Equatable, ViewportGeometric {
  public var viewportRect: CGRect
  public var anchor: UnitPoint
  public var canvasSize: CGSize

  /// Initialise with zero, so the instance gets set up,
  /// and then can update at runtime
  public init(
    viewportRect: CGRect = .zero,
    canvasSize: CGSize = .zero,
    anchor: UnitPoint = .center
  ) {
    self.viewportRect = viewportRect
    self.canvasSize = canvasSize
    self.anchor = anchor
  }
}

//extension CanvasGeometry {
//  public var isValidForCoordinateMapping: Bool {
//    viewportRect.width > 0
//      && viewportRect.height > 0
//      && canvasSize.width > 0
//      && canvasSize.height > 0
//  }
//
//  public func viewportContext(
//    zoom: CGFloat,
//    pan: CGSize
//  ) -> ViewportContext {
//    ViewportContext(
//      viewportRect: viewportRect,
//      pan: Point<ScreenSpace>(x: pan.width, y: pan.height),
//      zoom: zoom,
//      canvasSize: Size<CanvasSpace>(
//        width: canvasSize.width,
//        height: canvasSize.height
//      ),
//      canvasAnchor: anchor
//    )
//  }
//}
