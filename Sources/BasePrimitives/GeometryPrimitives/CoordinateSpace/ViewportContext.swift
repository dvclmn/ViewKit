//
//  CanvasViewportMapping.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 28/2/2026.
//

import SwiftUI

public struct CanvasViewportMapping {

  /// In global/screen space; includes safe-area origin and size.
  public var viewportRect: Rect​<​Screen​Space>
  //  public var viewportRect: CGRect

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

extension CanvasViewportMapping {

  private var zoomSafe: CGFloat {
    assert(zoom.isFinite, "CanvasViewportMapping: zoom became non-finite")
    /// I may consider a different value for max, like 20 or 80 or whatever makes sense
    return zoom.clamped(to: 0.06...CGFloat.greatestFiniteMagnitude)
  }

  /// The dynamic offset to center the canvas within the safe viewport area.
  /// This uses the size of the viewport (which already has insets subtracted).
  /// Canvas is scaled by zoom for centering; viewportRect is never scaled.
  private var centeringOffset: CGSize {

    /// Size of the canvas once zoom is applied
    let scaledCanvasWidth = canvasSize.width * zoomSafe
    let scaledCanvasHeight = canvasSize.height * zoomSafe

    /// Helper to compute offset for a given UnitPoint (0..1 in each axis)
    func offset(for anchor: UnitPoint) -> CGSize {
      /// Clamp to `[0,1]` to be safe for custom UnitPoints
      let ax = max(0, min(1, anchor.x))
      let ay = max(0, min(1, anchor.y))

      /// `anchor.x == 0 (leading)` content starts at 0 horizontally (no extra centering)
      /// `anchor.x == 0.5 (center)` split remaining space equally on both sides
      /// `anchor.x == 1 (trailing)` push content fully to the trailing edge
      let offsetX = (viewportRect.width - scaledCanvasWidth) * ax

      /// Same for vertical: 0 = top, 0.5 = center, 1 = bottom
      let offsetY = (viewportRect.height - scaledCanvasHeight) * ay

      return CGSize(width: offsetX, height: offsetY)
    }

    return switch canvasAnchor {
      case .center: offset(for: .center)
      case .top: offset(for: .top)
      case .bottom: offset(for: .bottom)
      case .leading: offset(for: .leading)
      case .trailing: offset(for: .trailing)
      case .topLeading: offset(for: .topLeading)
      case .topTrailing: offset(for: .topTrailing)
      case .bottomLeading: offset(for: .bottomLeading)
      case .bottomTrailing: offset(for: .bottomTrailing)
      default:
        /// For any custom UnitPoint, use its normalized x/y as fractions
        offset(for: canvasAnchor)
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
      origin: originCanvas.cgPoint,
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
