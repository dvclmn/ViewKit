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
  //  @Entry public var viewportSize: CGSize?
  @Entry public var viewportRect: CGRect?
  public var viewportSize: CGSize? {
    guard let viewportRect else { return nil }
    return viewportRect.size
  }

  @Entry public var canvasGeometry: CanvasGeometry = .init()

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

  /// Stabilises the existing Environment value for cornerRounding
  //  @Entry public var canvasRounding: Double?
  //  public func zoomAdjustedRounding(_ roundingOverride: Double? = nil) -> Double {
  //    guard let cornerRounding else { return nil }
  //    return cornerRounding.removingZoom(zoomLevel)
  //  }

  /// Aka artwork size, document size
  @Entry public var canvasSize: CGSize?
  
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
