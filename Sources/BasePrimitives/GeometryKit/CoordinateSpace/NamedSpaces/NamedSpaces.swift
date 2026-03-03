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
public enum ScreenSpace: Sendable {}  // Aka Viewport
public enum CanvasSpace: Sendable {}  // local, pre-transform
public enum GridSpace: Sendable {}  // ASCII art, cells etc

