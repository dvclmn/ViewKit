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

  public var canvasCGSize: CGSize { canvasSize.cgSize }

  public func viewportContext(from state: TransformState) -> ViewportContext? {
    viewportContext(zoom: state.zoomState.zoom, pan: state.panState.pan)
  }

  public func viewportContext(
    zoom: CGFloat,
    pan: CGSize
  ) -> ViewportContext? {
    guard isValidForCoordinateMapping else { return nil }
    return ViewportContext(
      viewportRect: viewportRect,
      pan: Point<ScreenSpace>(fromOffset: pan),
      zoom: zoom,
      canvasSize: canvasSize,
      canvasAnchor: anchor
    )
  }

  public var isValidForCoordinateMapping: Bool {
    viewportRect.width > 0
      && viewportRect.height > 0
      && canvasSize.width > 0
      && canvasSize.height > 0
  }
}
