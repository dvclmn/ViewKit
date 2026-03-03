//
//  CanvasCoordinateSpace.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/2/2026.
//

import BasePrimitives
import SwiftUI

extension EnvironmentValues {

  /// This is primarily expected to represent the whole window of an app,
  /// minus any base UI components like Toolbar or Inspector.
  ///
  /// Useful as long as its companion modifier
  /// `viewportCapture(mode:showsIndicator:didUpdateSize)`
  /// is placed on the view the caller regards as the viewport area
  @Entry public var viewportRect: CGRect?

  /// I think this should be removed, and callers just access `viewportRect`
  /// directly and get the size from there
  public var viewportSize: CGSize? {
    guard let viewportRect else { return nil }
    return viewportRect.size
  }

  /// This is usable by both Canvas and Grid domains. Describes the anchor
  /// used for SwiftUI layout by the main Artwork View in a CanvasView.
  /// Important for coordinate space calculations.
  @Entry public var canvasAnchor: UnitPoint = .center

  /// From CanvasKit
  @Entry public var zoomLevel: Double = 1.0
  @Entry public var zoomRange: ClosedRange<Double>?

  @Entry public var panOffset: CGSize = .zero
  @Entry public var rotation: Angle = .zero

  @Entry public var pointerLocation: CGPoint?

  public var zoomClamped: Double {
    guard let zoomRange else { return zoomLevel }
    return zoomLevel.clamped(to: zoomRange)
  }

  /// Aka artwork size, document size
  @Entry public var canvasSize: Size<CanvasSpace>?

  public var canvasGeometry: CanvasGeometry? {
    guard let viewportRect, let canvasSize else { return nil }
    return CanvasGeometry(
      viewportRect: viewportRect,
      canvasSize: canvasSize,
      anchor: canvasAnchor
    )
  }

  @Entry public var canvasBackground: Color = Color(white: 0.04)

}

/// This doesn't appear to be working? Or at least doesn't meet the SwiftUI requirement
///  where these can only be reached from inside the tagged view, or something?
//extension String {
//  /// For use with SwiftUI `coordinateSpace()`
//  public static var canvasIdentity: Self { "canvasIdentity" }
//  public static var canvasPanAndZoom: Self { "canvasPanAndZoom" }
//}
//
//extension NamedCoordinateSpace {
//  public static var canvasIdentity: Self { .named(String.canvasIdentity) }
//  public static var canvasPanAndZoom: Self { .named(String.canvasPanAndZoom) }
//}
//
//extension CoordinateSpace {
//  public static var canvasIdentity: Self { .named(String.canvasIdentity) }
//  public static var canvasPanAndZoom: Self { .named(String.canvasPanAndZoom) }
//}
