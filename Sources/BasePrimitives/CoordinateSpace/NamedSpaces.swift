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

  public var cgSize: CGSize {
    .init(width: width, height: height)
  }
}

public struct Rect<Space> {
  public var x: CGFloat
  public var y: CGFloat
  public var width: CGFloat
  public var height: CGFloat

  public init(
    x: CGFloat,
    y: CGFloat,
    width: CGFloat,
    height: CGFloat
  ) {
    self.x = x
    self.y = y
    self.width = width
    self.height = height
  }

  public init(
    origin: CGPoint,
    size: CGSize
  ) {
    self.x = origin.x
    self.y = origin.y
    self.width = size.width
    self.height = size.height
  }
}
