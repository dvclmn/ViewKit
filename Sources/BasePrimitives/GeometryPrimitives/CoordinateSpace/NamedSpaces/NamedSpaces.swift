//
//  NamedSpaces.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 28/2/2026.
//

import SwiftUI

/// For compile-time specialisation of e.g. ``Point`` like `Point<Space>`
///
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
  
  /// Named coordinate space for the interactive viewport container.
  public static let screen: String = "canvasScreen"
}

public enum CanvasSpace: Sendable, Hashable {

  /// Named coordinate space for the untransformed artwork/document container.
  /// Aka artwork.
  public static let canvas: String = "canvasArtwork"
}

/// For `convert(_:from:to:)` and other space-switching APIs
public enum TransformSpace {

  /// The coordinate space of the device screen (pan and zoom applied).
  case screen

  /// The local coordinate space of the canvas artwork (no pan, no zoom).
  case canvas
}
