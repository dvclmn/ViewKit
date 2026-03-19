//
//  CoordSpaceMapper.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 17/3/2026.
//

import Foundation

public struct CoordinateSpaceMapper {
  public let geometry: CanvasGeometry
  public let transform: TransformState
  public let zoomRange: ClosedRange<Double>?

  public init(
    geometry: CanvasGeometry,
    transform: TransformState,
    zoomRange: ClosedRange<Double>?
  ) {
    self.geometry = geometry
    self.transform = transform
    self.zoomRange = zoomRange
  }
}

extension CoordinateSpaceMapper {
  private var canvasSize: Size<CanvasSpace> { geometry.canvasSize }
  private var artworkFrame: Rect<ScreenSpace> { geometry.artworkFrameInViewport }
  private var zoomClamped: CGFloat {
    guard transform.scale.isFiniteAndGreaterThanZero else { return 1 }
    return transform.scale.clampedIfNeeded(to: zoomRange)
  }

  /// Convert screen-space point to canvas-space
  func canvasPoint(from screenPoint: Point<ScreenSpace>) -> Point<CanvasSpace> {
    //    let x = (screenPoint.x - artworkFrameInViewport.minX) / zoomClamped
    //    let y = (screenPoint.y - artworkFrameInViewport.minY) / zoomClamped

    Point<CanvasSpace>(
      //      x: max(0, x),
      //      y: max(0, y)
      x: (screenPoint.x - artworkFrame.minX) / zoomClamped,
      y: (screenPoint.y - artworkFrame.minY) / zoomClamped
    )
  }

  /// Convert canvas-space point to screen-space
  func screenPoint(from canvasPoint: Point<CanvasSpace>) -> Point<ScreenSpace> {
    fatalError("Not yet implemented")
  }

  private var canvasXRange: Range<CGFloat> { 0..<canvasSize.width }
  private var canvasYRange: Range<CGFloat> { 0..<canvasSize.height }

  public func isInsideCanvas(_ canvasPoint: Point<CanvasSpace>) -> Bool {
    canvasXRange.contains(canvasPoint.x)
      && canvasYRange.contains(canvasPoint.y)
  }
}
