//
//  ViewportGeometric.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/3/2026.
//

import SwiftUI

public protocol ViewportGeometric: Sendable, Equatable {
  var viewportRect: CGRect { get }
  var canvasSize: Size<CanvasSpace> { get }
  var anchor: UnitPoint { get }
}

extension ViewportGeometric {
  public func viewportContext(
    zoom: CGFloat,
    pan: CGSize
  ) -> ViewportContext {
    ViewportContext(
      viewportRect: viewportRect,
      pan: Point<ScreenSpace>(x: pan.width, y: pan.height),
      zoom: zoom,
      canvasSize: canvasSize,
      canvasAnchor: anchor
    )
  }

  public var isValidForCoordinateMapping: Bool {
    viewportRect.width > 0 && viewportRect.height > 0 && canvasSize.width > 0 && canvasSize.height > 0
  }
}
