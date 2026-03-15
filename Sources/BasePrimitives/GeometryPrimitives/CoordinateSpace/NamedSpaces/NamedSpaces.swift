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

/// Full size Viewport — should represent the App Window dimensions,
/// sans UI elements like sidebar, inspector, toolbar etc.
public enum ScreenSpace: Sendable, Hashable {
  public static let safeArea: String = "screenSafeArea"
}

/// Local Artwork space, pre-transform (before zoom, pan etc)
public enum CanvasSpace: Sendable, Hashable {
  
  /// Named coordinate space for the interactive viewport container.
  /// I think this will usually be the same as ``ScreenSpace/safeArea``?
  public static let viewport: String = "canvasViewport"

  /// Named coordinate space for the untransformed artwork/document container.
  public static let artwork: String = "canvasArtwork"

}

/// ASCII art, cells etc
//public enum GridSpace: Sendable, Hashable {}
