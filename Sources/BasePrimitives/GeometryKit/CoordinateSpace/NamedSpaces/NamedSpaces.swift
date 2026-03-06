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
  /// Named coordinate space for the interactive viewport container.
  public static let viewport: String = "canvasViewport"

  /// Named coordinate space for the untransformed artwork/document container.
  public static let artwork: String = "canvasArtwork"

  /// Legacy alias retained for compatibility while migrating call sites.
  public static let safeArea: String = viewport
}  // local, pre-transform
public enum GridSpace: Sendable, Hashable {}  // ASCII art, cells etc
