//
//  CoordinateSpaceContext.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/2/2026.
//

import Foundation

public enum ViewAnchor {
  /// Trying to express; SwiftUI anchors my View to the centre by default,
  /// calculations must take that into account
  case anchoredToCentre
}

public enum PanSpace {
  /// Pan is expressed in global/screen points (already scaled)
  case global
  /// Pan is expressed in local/canvas points (independent of zoom)
  case local
}

/// Global == viewport == screen space
/// Canvas == Local space
///
/// I may consider either including `CanvasGeometry` in this,
/// or actually just removing that entirely and absorbing into this type
public struct CoordinateSpaceContext {
  //public struct CoordinateSpaceTransform {

  let viewAnchor: ViewAnchor

  /// Scale factor applied to canvas (>= 0).
  let zoom: CGFloat
  /// Translation of canvas; units depend on panSpace.
  let pan: CGSize
  let panSpace: PanSpace

  /// In global/screen space; includes safe-area origin and size.
  let viewportRect: CGRect
  /// In local/canvas space (unscaled).
  let canvasSize: CGSize

  public init(
    viewAnchor: ViewAnchor,
    zoom: CGFloat,
    pan: CGSize,
    viewportRect: CGRect,
    canvasSize: CGSize,
    panSpace: PanSpace
  ) {
    self.viewAnchor = viewAnchor
    self.zoom = zoom
    self.pan = pan
    self.panSpace = panSpace
    self.viewportRect = viewportRect
    self.canvasSize = canvasSize
  }
}

extension CoordinateSpaceContext {

  /// Pan normalized to global space. If the input pan is in local/canvas units,
  /// scale it by `zoom` to convert to global points; otherwise use as-is.
  private var panInGlobalSpace: CGSize {
    switch panSpace {
      case .global:
        return pan
      case .local:
        return CGSize(width: pan.width * zoom, height: pan.height * zoom)
    }
  }

  /// The dynamic offset to center the canvas within the safe viewport area.
  /// This uses the size of the viewport (which already has insets subtracted).
  /// Canvas is scaled by zoom for centering; viewportRect is never scaled.
  private var centeringOffset: CGSize {
    switch viewAnchor {
      case .anchoredToCentre:
        return CGSize(
          width: (viewportRect.width - (canvasSize.width * zoom)) / 2,
          height: (viewportRect.height - (canvasSize.height * zoom)) / 2
        )
    }
  }

  /// The "Zero Point" of your drawing area in screen space.
  /// Safe Area Origin + Centering + Manual Pan.
  private var totalGlobalOffset: CGPoint {
    CGPoint(
      x: viewportRect.origin.x + centeringOffset.width + panInGlobalSpace.width,
      y: viewportRect.origin.y + centeringOffset.height + panInGlobalSpace.height
    )
  }

  /// Converts a global/screen space point to local / canvas point
  public func toLocal(point: CGPoint) -> CGPoint {
    /// 1. Subtract the total translation from the raw screen point
    /// 2. Divide by zoom to get the coordinate on the "original" canvas scale
    CGPoint(
      x: (point.x - totalGlobalOffset.x) / zoom,
      y: (point.y - totalGlobalOffset.y) / zoom
    )
  }

  /// Converts a canvas-local point back to screen/global space
  public func toGlobal(point: CGPoint) -> CGPoint {
    /// 1. Scale the local point up
    /// 2. Add the total translation to place it correctly on the screen
    CGPoint(
      x: (point.x * zoom) + totalGlobalOffset.x,
      y: (point.y * zoom) + totalGlobalOffset.y
    )
  }
}
