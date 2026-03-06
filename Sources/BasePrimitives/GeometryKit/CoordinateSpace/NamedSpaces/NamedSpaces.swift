//
//  NamedSpaces.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 28/2/2026.
//

import Foundation

/// ```
/// func toCanvas(
///   _ p: Point<ScreenSpace>,
///   context: CoordinateSpaceContext
/// ) -> Point<CanvasSpace>
///
/// func toGrid(
///   _ p: Point<CanvasSpace>,
///   unitSize: CGSize
/// ) -> GridPoint?
/// ```
public enum ScreenSpace: Sendable, Hashable {
  public static let safeArea: String = "screenSafeArea"
}  // Aka Viewport
public enum CanvasSpace: Sendable, Hashable {
  public static let safeArea: String = "canvasSafeArea"
}  // local, pre-transform
public enum GridSpace: Sendable, Hashable {}  // ASCII art, cells etc

