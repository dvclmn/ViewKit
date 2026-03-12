//
//  CanvasCoordinateSpace.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/2/2026.
//

import SwiftUI

//extension EnvironmentValues {
//  @Entry public var isResizingCanvas: Bool = false
//  @Entry public var shouldRenderDragRect: Bool = true
//}

extension EnvironmentValues {

  // MARK: - Geometry
  /// This is usable by both Canvas and Grid domains. Describes the anchor
  /// used for SwiftUI layout by the main Artwork View in a CanvasView.
  /// Important for coordinate space calculations.
  @Entry public var canvasAnchor: UnitPoint = .center

  /// Aka artwork size, document size
  @Entry public var canvasSize: Size<CanvasSpace>?
  @Entry public var canvasFrameInViewport: CGRect?
  @Entry public var canvasBackground: Color = Color(white: 0.04)
  
  @Entry public var canvasInteractionPolicy: CanvasPolicy = .default
  
  public var canvasGeometry: CanvasGeometry? {
    guard let viewportRect, let canvasSize else { return nil }
    return CanvasGeometry(
      viewportRect: viewportRect,
      canvasSize: canvasSize,
      anchor: canvasAnchor
    )
  }

  @Entry public var zoomLevel: Double = 1.0
  @Entry public var zoomRange: ClosedRange<Double>?

  @Entry public var panOffset: CGSize = .zero
  @Entry public var rotation: Angle = .zero
  @Entry public var pointerLocation: CGPoint?

  public var zoomClamped: Double {
    guard let zoomRange else { return zoomLevel }
    return zoomLevel.clamped(to: zoomRange)
  }

}
