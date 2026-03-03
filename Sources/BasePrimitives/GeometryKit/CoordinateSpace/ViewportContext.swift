//
//  ViewportContext.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 28/2/2026.
//

import SwiftUI

/// - The user creates a document of `GridDimensions(width: 80, height: 40)`.
/// - You define a `GridProjection(cellSize: CGSize(width: 10, height: 18))`.
/// - You set up your `ViewportContext` where `canvasSize` is automatically
///   calculated via `projection.canvasSize(for: dimensions)`.
/// - When a user taps the screen:
///   - `ViewportContext` converts the screen tap `CGPoint` to a Canvas
///     `CGPoint` (handling pan/zoom perfectly).
///   - `GridProjection` converts that Canvas `CGPoint` into a Grid Point (Int, Int).
///   - You now know exactly which ASCII cell they tapped, regardless of
///     zoom level or pan translation!

/// Manages the continuous relationship between the Viewport and the Canvas.
///
/// Usage in a View/Gesture:
/// ```
/// let tap = Point<ScreenSpace>(x: gesture.location.x, y: gesture.location.y)
/// let canvasPoint = viewport.convertToCanvas(tap)
/// let gridPos = projection.gridPosition(from: canvasPoint)
/// ```

/// `gridPos` is now a pure (column, row) you can use to look up your ASCII character!
///
/// This is the successor of older `CoordinateSpaceContext`
public struct ViewportContext {

  /// In global/screen space; includes safe-area origin and size.
  public var viewportRect: CGRect

  /// Note: no need for previous `panInGlobalSpace`; this is always in
  /// screen/global space now.
  public var pan: Point<ScreenSpace>
  public var zoom: CGFloat

  /// This is the "subject" (the document) size in Canvas units.
  /// In local/canvas space (unscaled).
  public var canvasSize: Size<CanvasSpace>
  public var canvasAnchor: UnitPoint

  public init(
    viewportRect: CGRect,
    pan: Point<ScreenSpace>,
    zoom: CGFloat,
    canvasSize: Size<CanvasSpace>,
    canvasAnchor: UnitPoint
  ) {
    self.viewportRect = viewportRect
    self.pan = pan
    self.zoom = zoom
    self.canvasSize = canvasSize
    self.canvasAnchor = canvasAnchor
  }
}

extension ViewportContext {

  private var zoomSafe: CGFloat {
    zoom.clamped(to: 0.01...CGFloat.greatestFiniteMagnitude)
    //    guard zoom.isFinite, zoom > 0 else { return 1 }
    //    return zoom
  }
  /// The dynamic offset to center the canvas within the safe viewport area.
  /// This uses the size of the viewport (which already has insets subtracted).
  /// Canvas is scaled by zoom for centering; viewportRect is never scaled.
  private var centeringOffset: CGSize {
    switch canvasAnchor {
      case .center:
        return CGSize(
          width: (viewportRect.width - (canvasSize.width * zoomSafe)) / 2,
          height: (viewportRect.height - (canvasSize.height * zoomSafe)) / 2
        )

      default: fatalError("Not yet implemented")
    }
  }

  /// Canvas frame expressed in global/screen space.
  public var canvasFrameInGlobalSpace: CGRect {
    CGRect(
      origin: totalGlobalOffset,
      size: CGSize(
        width: canvasSize.width * zoomSafe,
        height: canvasSize.height * zoomSafe
      )
    )
  }

  /// The "Zero Point" of your drawing area in screen space.
  /// Safe Area Origin + Centering + Manual Pan.
  private var totalGlobalOffset: CGPoint {
    CGPoint(
      x: viewportRect.origin.x + centeringOffset.width + pan.x,
      y: viewportRect.origin.y + centeringOffset.height + pan.y
    )
  }

  /// Converts a global/screen space point to local / canvas point
  /// Previously: `toLocal(point:) - > CGPoint`
  public func toCanvas(screenPoint point: Point<ScreenSpace>) -> Point<CanvasSpace> {
    //  public func toLocal(point: CGPoint) -> CGPoint {
    /// 1. Subtract the total translation from the raw screen point
    /// 2. Divide by zoom to get the coordinate on the "original" canvas scale
    Point<CanvasSpace>(
      x: (point.x - totalGlobalOffset.x) / zoomSafe,
      y: (point.y - totalGlobalOffset.y) / zoomSafe
    )
  }

  /// Converts a canvas-local point back to screen/global space
  public func toGlobal(point: CGPoint) -> CGPoint {
    /// 1. Scale the local point up
    /// 2. Add the total translation to place it correctly on the screen
    CGPoint(
      x: (point.x * zoomSafe) + totalGlobalOffset.x,
      y: (point.y * zoomSafe) + totalGlobalOffset.y
    )
  }

  /// Converts a global/screen rect to local/canvas rect.
  public func toCanvas(rect: CGRect) -> CGRect {
    let originCanvas = toCanvas(screenPoint: Point<ScreenSpace>(fromPoint: rect.origin))
    return CGRect(
      origin: CGPoint(x: originCanvas.x, y: originCanvas.y),
      size: CGSize(
        width: rect.width / zoomSafe,
        height: rect.height / zoomSafe
      )
    )
  }

  /// Converts a local/canvas rect to global/screen rect.
  public func toGlobal(rect: CGRect) -> CGRect {
    CGRect(
      origin: toGlobal(point: rect.origin),
      size: CGSize(
        width: rect.width * zoomSafe,
        height: rect.height * zoomSafe
      )
    )
  }
}
