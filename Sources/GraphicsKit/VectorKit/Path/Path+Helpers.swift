//
//  Path.swift
//  BaseHelpers
//
//  Created by Dave Coleman on 6/7/2025.
//

import SwiftUI

extension Path {

  public var toCGPath: CGPath { self.cgPath }

  /// Adds a variant of standard `Path/move(to:)` taking a
  /// `UnitPoint` and `CGSize`, instead of a `CGPoint`
  public mutating func move(to unitPoint: UnitPoint, in size: CGSize) {
    let point = unitPoint.toCGPoint(in: size)
    self.move(to: point)
  }

  /// Adds a variant of standard `Path/addLine(to:)` taking a
  /// `UnitPoint` and `CGSize`, instead of a `CGPoint`
  public mutating func addLine(to unitPoint: UnitPoint, in size: CGSize) {
    let point = unitPoint.toCGPoint(in: size)
    self.addLine(to: point)
  }

  /// Initialises a Path with a rect at `size` dimensions, and origin of `zero`
  public init(fromSize size: CGSize) {
    self.init(CGRect(origin: .zero, size: size))
  }

  public init(
    fromPoints points: [CGPoint],
    type: PathStyle = .line,
    shouldDropFirst: Bool = true
  ) {
    self = points.createPath(type: type, shouldDropFirst: shouldDropFirst)
  }
}

extension Path {

  /// Appends a point marker shape at a given point with a visual radius.
  ///
  /// This helper computes the center-origin rect parameters and delegates to
  /// `PointShape.updatePath(center:radius:path:)` to avoid redundant geometry work.
  /// - Parameters:
  ///   - point: Center position where the marker should be drawn.
  ///   - shape: The marker shape to draw. Defaults to `.circle`.
  ///   - radius: The visual radius/half-extent for the marker.
  public mutating func addShape(
    at point: CGPoint,
    using shape: PointShape = .circle,
    radius: CGFloat,
  ) {
    shape.addShape(to: &self, at: point, radius: radius)
  }
}
