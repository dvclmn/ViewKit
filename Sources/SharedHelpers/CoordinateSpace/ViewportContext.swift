//
//  ViewportContext.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 28/2/2026.
//

import SwiftUI
import BasePrimitives

/// ## Paradigm 1: Standard Pixel App (Photoshop style)
/// You just use ViewportContext. The subjectSize is the raw document size, e.g.,
/// `CGSize(width: 1920, height: 1080)`.
///
/// You don't use `GridProjection` or `GridDimensions` at all.
///
/// ## Paradigm 2: Grid App (ASCII style)
/// You use both.
///
/// - The user creates a document of GridDimensions(width: 80, height: 40).
/// - You define a GridProjection(cellSize: CGSize(width: 10, height: 18)).
/// - You set up your ViewportContext where subjectSize is automatically
///   calculated via projection.canvasSize(for: dimensions).
/// - When a user taps the screen:
///   - ViewportContext converts the screen tap CGPoint to a Canvas
///     CGPoint (handling pan/zoom perfectly).
///   - GridProjection converts that Canvas CGPoint into a GridPoint (Int, Int).
///   - You now know exactly which ASCII cell they tapped, regardless of
///     zoom level or pan translation!

/// Manages the continuous relationship between the Viewport and the Canvas.
///
/// // Usage in a View/Gesture:
/// ```
/// let tap = Point<ScreenSpace>(x: gesture.location.x, y: gesture.location.y)
/// let canvasPoint = viewport.convertToCanvas(tap)
/// let gridPos = projection.gridPosition(from: canvasPoint)
/// ```

/// gridPos is now a pure (column, row) you can use to look up your ASCII character!
public struct ViewportContext {
  /// In global/screen space; includes safe-area origin and size.
  public var viewportRect: CGRect // ScreenSpace
  public var pan: Point<ScreenSpace>
  public var zoom: CGFloat
  
  // This is the "subject" (the document) size in Canvas units.
  public var canvasSize: Size<CanvasSpace>
  
  /// In local/canvas space (unscaled).
  /// If this is a Grid document, this is derived from `GridProjection.canvasSize()`.
//  public var subjectSize: CGSize
//  public var subjectAnchor: UnitPoint
//  
//  public var zoom: CGFloat
//  public var pan: CGSize
  
  // MARK: - Conversions
  
  /// Converts a touch location on the screen into a coordinate on the canvas.
//  public func canvasLocation(for screenPoint: CGPoint) -> CGPoint {
//    // 1. Adjust for Viewport origin
//    let xInViewport = screenPoint.x - viewportRect.minX
//    let yInViewport = screenPoint.y - viewportRect.minY
//    
//    // 2. Reverse Pan
//    let unpannedX = xInViewport - pan.width
//    let unpannedY = yInViewport - pan.height
//    
//    // 3. Reverse Zoom
//    let canvasX = unpannedX / zoom
//    let canvasY = unpannedY / zoom
//    
//    return CGPoint(x: canvasX, y: canvasY)
//  }
  
  /// Step 1: Screen -> Canvas
  func convertToCanvas(_ screenPoint: Point<ScreenSpace>) -> Point<CanvasSpace> {
    // The math stays here, protected by the types
    let x = (screenPoint.x - viewportRect.minX - pan.x) / zoom
    let y = (screenPoint.y - viewportRect.minY - pan.y) / zoom
    return Point<CanvasSpace>(x: x, y: y)
  }
}
