//
//  Point.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 3/3/2026.
//

import Foundation

/// Allows differentiating one `CGPoint` from another, to make it clearer
/// and easier to move between different coordinate spaces, with compile-time safety.
///
/// E.g.

/// ```
/// enum ScreenSpace {}
/// enum CanvasSpace {}
///
/// func drawHandle(at point: Point<ScreenSpace>) { ... }
/// let canvasPoint: Point<CanvasSpace> = .init(x: 120, y: 80)
///
/// ```
///
/// Compile error – wrong space:
/// `drawHandle(at: canvasPoint)`
///
/// Make the conversion explicit via the mapping:
///
/// ```
/// let mapping: ViewportMapping = ... // produced from geometry + transform
/// let screenPoint = mapping.toGlobal(point: canvasPoint.cgPoint) // or a space-aware overload
/// drawHandle(at: Point<ScreenSpace>(fromPoint: screenPoint))
/// ```
public struct Point<Space>: Sendable, Equatable {
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

  public init(fromOffset point: CGSize) {
    self.x = point.width
    self.y = point.height
  }
}

extension Point {
  public var cgPoint: CGPoint {
    .init(x: x, y: y)
  }
}
