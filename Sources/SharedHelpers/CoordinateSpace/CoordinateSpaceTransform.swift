//
//  CoordinateSpaceTransform.swift
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

/// Global == viewport == screen space
/// Canvas == Local space
///
/// I may consider either including `CanvasGeometry` in this,
/// or actually just removing that entirely and absorbing into this type
public struct CoordinateSpaceTransform {

  let viewAnchor: ViewAnchor

  let zoom: CGFloat
  let pan: CGSize

  /// Global viewport rect, where `size` is inset by
  /// `origin`, to express safe area insets
  let viewportRect: CGRect
  let canvasSize: CGSize

  public init(
    viewAnchor: ViewAnchor,
    zoom: CGFloat,
    pan: CGSize,
    viewportRect: CGRect,
    canvasSize: CGSize
  ) {
    self.viewAnchor = viewAnchor
    self.zoom = zoom
    self.pan = pan
    self.viewportRect = viewportRect
    self.canvasSize = canvasSize
  }
}

extension CoordinateSpaceTransform {

  /// The dynamic offset to center the canvas within the safe viewport area.
  /// This uses the size of the viewport (which already has insets subtracted).
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
      x: viewportRect.origin.x + centeringOffset.width + pan.width,
      y: viewportRect.origin.y + centeringOffset.height + pan.height
    )
  }

  /// Converts a global/screen space point to local / canvas point
  public func toLocal(point: CGPoint) -> CGPoint {
    // 1. Subtract the total translation from the raw screen point
    // 2. Divide by zoom to get the coordinate on the "original" canvas scale
    CGPoint(
      x: (point.x - totalGlobalOffset.x) / zoom,
      y: (point.y - totalGlobalOffset.y) / zoom
    )
  }

  /// Converts a canvas-local point back to screen/global space
  public func toGlobal(point: CGPoint) -> CGPoint {
    // 1. Scale the local point up
    // 2. Add the total translation to place it correctly on the screen
    CGPoint(
      x: (point.x * zoom) + totalGlobalOffset.x,
      y: (point.y * zoom) + totalGlobalOffset.y
    )
  }
}
