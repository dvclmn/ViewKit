//
//  CanvasCoordinateSpace.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 25/2/2026.
//

import SwiftUI

extension String {
  /// For use with SwiftUI `coordinateSpace()`
  public static var canvasIdentity: Self { "canvasIdentity" }
  public static var canvasPanAndZoom: Self { "canvasPanAndZoom" }
}

extension NamedCoordinateSpace {
  public static var canvasIdentity: Self { .named(String.canvasIdentity) }
  public static var canvasPanAndZoom: Self { .named(String.canvasPanAndZoom) }
}

extension CoordinateSpace {
  public static var canvasIdentity: Self { .named(String.canvasIdentity) }
  public static var canvasPanAndZoom: Self { .named(String.canvasPanAndZoom) }
}
