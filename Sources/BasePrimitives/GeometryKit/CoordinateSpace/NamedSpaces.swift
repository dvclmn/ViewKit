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

public struct Point<Space>: Sendable {
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

public struct Size<Space>: Sendable, Equatable {
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

extension Size {
  public static var zero: Self {
    .init(width: 0, height: 0)
  }
}

public struct Rect<Space>: Sendable {
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
