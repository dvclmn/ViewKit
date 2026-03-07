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

  public var canvasGeometry: CanvasGeometry? {
    guard let viewportRect, let canvasSize else { return nil }
    return CanvasGeometry(
      viewportRect: viewportRect,
      canvasSize: canvasSize,
      anchor: canvasAnchor
    )
  }

  // MARK: - Input Events
  @Entry public var pointerState: Binding<PointerState>?
  @Entry public var transformState: Binding<TransformState>?
  //  @Entry public var canvasState: Binding<CanvasTransformState>?

  /// From CanvasKit
  //  @Entry public var zoomLevel: Double = 1.0
  //  @Entry public var panOffset: CGSize = .zero
  //  @Entry public var rotation: Angle = .zero
  //  @Entry public var pointerLocation: CGPoint?

  public var zoomLevel: Double {
    transformState?.wrappedValue.zoomState.zoom ?? 1.0
  }
  public var panOffset: CGSize {
    transformState?.wrappedValue.panState.pan ?? .zero
  }
  public var rotation: Angle {
    transformState?.wrappedValue.rotationState.value ?? .zero
  }
  public var pointerLocation: CGPoint? {
    pointerState?.wrappedValue.pointerHover.value
  }

  @Entry public var zoomRange: ClosedRange<Double>?

  public var zoomClamped: Double {
    guard let zoomRange else { return zoomLevel }
    return zoomLevel.clamped(to: zoomRange)
  }

}
