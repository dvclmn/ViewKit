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

public struct CoordinateSpaceTransform {
  let viewAnchor: ViewAnchor

  let zoom: CGFloat
  let pan: CGSize

  /// Global size
  let viewportSize: CGSize
  
  public init(
    viewAnchor: ViewAnchor,
    zoom: CGFloat,
    pan: CGSize,
    viewportSize: CGSize
  ) {
    self.viewAnchor = viewAnchor
    self.zoom = zoom
    self.pan = pan
    self.viewportSize = viewportSize
  }

}

extension CoordinateSpaceTransform {

  /// Converts a global/screen space point to local / canvas point
  /// *Removes* pan and zoom.
  public func toLocal(point: CGPoint) -> CGPoint {
    CGPoint(
      x: (point.x - pan.width) / zoom,
      y: (point.y - pan.height) / zoom
    )
  }

  /// Converts a canvas-local point back to screen/global space
  public func toGlobal(point: CGPoint) -> CGPoint {
    return CGPoint(
      x: (point.x * zoom) + pan.width,
      y: (point.y * zoom) + pan.height
    )
  }
}
