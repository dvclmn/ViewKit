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
public enum ScreenSpace {}
public enum CanvasSpace {}  // local, pre-transform
public enum GridSpace {}

public struct Point<Space> {
  public var x: CGFloat
  public var y: CGFloat
}

public struct Size<Space> {
  public var width: CGFloat
  public var height: CGFloat
}

/// Grid-specific
public struct GridPoint {
  public var column: Int
  public var row: Int
}
