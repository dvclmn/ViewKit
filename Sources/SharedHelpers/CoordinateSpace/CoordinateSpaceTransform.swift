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

/// Lingo:
///
/// Global == viewport == screen space
/// Canvas == Local space
public struct CoordinateSpaceTransform {

  /// Want to know:
  /// - How big would the canvas size be inside the viewport size

  let viewAnchor: ViewAnchor

  let zoom: CGFloat
  let pan: CGSize

  /// Global size
  let viewportSize: CGSize
  let canvasSize: CGSize

  public init(
    viewAnchor: ViewAnchor,
    zoom: CGFloat,
    pan: CGSize,
    viewportSize: CGSize,
    canvasSize: CGSize
  ) {
    self.viewAnchor = viewAnchor
    self.zoom = zoom
    self.pan = pan
    self.viewportSize = viewportSize
    self.canvasSize = canvasSize
  }

}

extension CoordinateSpaceTransform {

  /// The implicit offset required to center the canvas in the viewport
  /// before any manual panning is applied.
  private var centeringOffset: CGSize {
    switch viewAnchor {
      case .anchoredToCentre:
        return CGSize(
          width: (viewportSize.width - (canvasSize.width * zoom)) / 2,
          height: (viewportSize.height - (canvasSize.height * zoom)) / 2
        )
    }
  }

  /// The combined translation: Centering + User Pan
  private var totalOffset: CGSize {
    CGSize(
      width: centeringOffset.width + pan.width,
      height: centeringOffset.height + pan.height
    )
  }

  /// Converts a global/screen space point to local / canvas point
  public func toLocal(point: CGPoint) -> CGPoint {
    CGPoint(
      x: (point.x - totalOffset.width) / zoom,
      y: (point.y - totalOffset.height) / zoom
    )
  }

  /// Converts a canvas-local point back to screen/global space
  public func toGlobal(point: CGPoint) -> CGPoint {
    CGPoint(
      x: (point.x * zoom) + totalOffset.width,
      y: (point.y * zoom) + totalOffset.height
    )
  }

  //  /// Converts a global/screen space point to local / canvas point
  //  /// *Removes* pan and zoom.
  //  public func toLocal(point: CGPoint) -> CGPoint {
  //    CGPoint(
  //      x: (point.x - pan.width) / zoom,
  //      y: (point.y - pan.height) / zoom
  //    )
  //  }
  //
  //  /// Converts a canvas-local point back to screen/global space
  //  public func toGlobal(point: CGPoint) -> CGPoint {
  //    return CGPoint(
  //      x: (point.x * zoom) + pan.width,
  //      y: (point.y * zoom) + pan.height
  //    )
  //  }
}
