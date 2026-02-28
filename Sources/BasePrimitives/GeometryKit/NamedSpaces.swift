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
public enum ScreenSpace {}  // Aka Viewport
public enum CanvasSpace {}  // local, pre-transform
public enum GridSpace {}  // ASCII art, cells etc

public struct Point<Space> {
  public var x: CGFloat
  public var y: CGFloat

  public init(x: CGFloat, y: CGFloat) {
    self.x = x
    self.y = y
  }

  public init(fromPoint point: CGPoint) {
    self.x = point.x
    self.y = point.y
  }
}

public struct Size<Space> {
  public var width: CGFloat
  public var height: CGFloat

  public init(width: CGFloat, height: CGFloat) {
    self.width = width
    self.height = height
  }
}

public struct Rect<Space> {
//  public var origin: CGPoint
  public var width: CGFloat
  public var height: CGFloat

  public init(
    origin: CGPoint,
    width: CGFloat,
    height: CGFloat
  ) {
    self.origin = origin
    self.width = width
    self.height = height
  }
}
