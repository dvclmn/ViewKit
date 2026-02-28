//
//  CoordinateSpaceContext.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/2/2026.
//

import BasePrimitives
import SwiftUI

/// Global == viewport == screen space
/// Canvas == Local space
///
/// I may consider either including `CanvasGeometry` in this,
/// or actually just removing that entirely and absorbing into this type
public struct CoordinateSpaceContext {
  //public struct CoordinateSpaceContext<Geometry: GeometryContext> where Geometry.Size == CGSize {
  //public struct CoordinateSpaceTransform {

  /// Scale factor applied to canvas (>= 0).
  let zoom: CGFloat
  /// Translation of canvas; units depend on panSpace.
  let pan: CGSize
  let panSpace: PanSpace

  /// In global/screen space; includes safe-area origin and size.
  let viewportRect: CGRect

  /// In local/canvas space (unscaled).
  let subjectSize: CGSize
  
  /// Describes how SwiftUI is handling layout for `subjectSize`,
  /// important for correctly calculating many things.
  let subjectAnchor: UnitPoint

  public init(
    zoom: CGFloat,
    pan: CGSize,
    panSpace: PanSpace,
    viewportRect: CGRect,
    subjectSize: CGSize,
    subjectAnchor: UnitPoint
  ) {
    self.zoom = zoom
    self.pan = pan
    self.panSpace = panSpace
    self.viewportRect = viewportRect
    self.subjectSize = subjectSize
    self.subjectAnchor = subjectAnchor
  }
}

extension CoordinateSpaceContext {

  //  public init(
  public init?<T: GeometryContext>(
    zoom: CGFloat,
    pan: CGSize,
    panSpace: PanSpace,
    geometry: T,
    unitSize: CGSize
  ) where T.Size == UnitSize {
    self.zoom = zoom
    self.pan = pan
    self.panSpace = panSpace

    self.viewportRect = geometry.viewportRect

    guard let size = geometry.subjectSize.toCGSize else {
      //      preconditionFailure("See ")
      return nil
    }
    self.subjectSize = size
    self.subjectAnchor = geometry.subjectAnchor
  }

  private var zoomSafe: CGFloat {
    zoom.clamped(to: 0.01...CGFloat.greatestFiniteMagnitude)
    //    guard zoom.isFinite, zoom > 0 else { return 1 }
    //    return zoom
  }

  /// Pan normalized to global space. If the input pan is in local/canvas units,
  /// scale it by `zoom` to convert to global points; otherwise use as-is.
  private var panInGlobalSpace: CGSize {
    switch panSpace {
      case .global: pan
      case .local:
        CGSize(
          width: pan.width * zoomSafe,
          height: pan.height * zoomSafe
        )
    }
  }

  /// The dynamic offset to center the canvas within the safe viewport area.
  /// This uses the size of the viewport (which already has insets subtracted).
  /// Canvas is scaled by zoom for centering; viewportRect is never scaled.
  private var centeringOffset: CGSize {
    switch subjectAnchor {
      case .center:
        return CGSize(
          width: (viewportRect.width - (subjectSize.width * zoomSafe)) / 2,
          height: (viewportRect.height - (subjectSize.height * zoomSafe)) / 2
        )

      default: fatalError("Not yet implemented")
    }
  }

  /// Canvas frame expressed in global/screen space.
  public var canvasFrameInGlobalSpace: CGRect {
    CGRect(
      origin: totalGlobalOffset,
      size: CGSize(
        width: subjectSize.width * zoomSafe,
        height: subjectSize.height * zoomSafe
      )
    )
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
  public func toLocal(rect: CGRect) -> CGRect {
    CGRect(
      origin: toLocal(point: rect.origin),
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

  //  public func dragRect(for rect: CGRect) -> CGRect? {
  //    mapToCanvas(viewportRect: rect)
  //  }

  //  public func tapLocation(for location: CGPoint) -> CGPoint? {
  //    mapToCanvas(viewportPoint: location)
  //  }

}

extension CoordinateSpaceContext {

  #if DEBUG
  /// Distance error for round-tripping a global point through local space.
  public func roundTripError(global point: CGPoint) -> CGFloat {
    let local = toLocal(point: point)
    let result = toGlobal(point: local)
    return hypot(result.x - point.x, result.y - point.y)
  }

  /// Distance error for round-tripping a local point through global space.
  public func roundTripError(local point: CGPoint) -> CGFloat {
    let global = toGlobal(point: point)
    let result = toLocal(point: global)
    return hypot(result.x - point.x, result.y - point.y)
  }

  @discardableResult
  public func assertRoundTrip(
    global point: CGPoint,
    tolerance: CGFloat = 0.5,
    file: StaticString = #fileID,
    line: UInt = #line
  ) -> CGFloat {
    let error = roundTripError(global: point)
    assert(
      error <= tolerance,
      "Coordinate transform round-trip failed (global->local->global). Error: \(error), tolerance: \(tolerance)",
      file: file,
      line: line
    )
    return error
  }

  @discardableResult
  public func assertRoundTrip(
    local point: CGPoint,
    tolerance: CGFloat = 0.5,
    file: StaticString = #fileID,
    line: UInt = #line
  ) -> CGFloat {
    let error = roundTripError(local: point)
    assert(
      error <= tolerance,
      "Coordinate transform round-trip failed (local->global->local). Error: \(error), tolerance: \(tolerance)",
      file: file,
      line: line
    )
    return error
  }
  #endif
}
