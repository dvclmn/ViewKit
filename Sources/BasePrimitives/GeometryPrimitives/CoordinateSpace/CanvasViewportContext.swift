//
//  CanvasViewportContext.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/3/2026.
//

import SwiftUI

public protocol CanvasViewportContext: Sendable, Equatable {
  var viewportRect: Rect<ScreenSpace> { get }
  var canvasSize: Size<CanvasSpace> { get }
  var anchor: UnitPoint { get }
}

extension CanvasViewportContext {

  public var canvasCGSize: CGSize { canvasSize.cgSize }

  public func viewportMapping(from state: TransformState) -> CanvasViewportMapping? {
    viewportMapping(zoom: state.zoom.value, pan: state.pan.value)
  }

  public func viewportMapping(
    zoom: CGFloat,
    pan: CGSize
  ) -> CanvasViewportMapping? {
    guard isValidForCoordinateMapping else { return nil }
    return CanvasViewportMapping(
      viewportRect: viewportRect,
      pan: Point<ScreenSpace>(fromOffset: pan),
      zoom: zoom,
      canvasSize: canvasSize,
      anchor: anchor
    )
  }

  public var isValidForCoordinateMapping: Bool {
    viewportRect.width > 0
      && viewportRect.height > 0
      && canvasSize.width > 0
      && canvasSize.height > 0
  }
}
